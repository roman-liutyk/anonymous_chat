import 'dart:io';

import 'package:api/errors/custom_exception.dart';
import 'package:api/services/auth_service.dart';
import 'package:api/utils/jwt_helper.dart';
import 'package:dart_frog/dart_frog.dart';

/// Handles incoming HTTP requests and returns appropriate responses.
/// 
/// Successful response can be returned onfy for POST request.
/// For all other request will be returned status [HttpStatus.methodNotAllowed].
///
/// [context] represents the request context containing the request details.
///
/// Returns [Response] representing the response to be sent back to the client.
Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.post => _onPost(context),
    _ => Future.value(
        Response(statusCode: HttpStatus.methodNotAllowed),
      ),
  };
}

/// Handles POST requests for user registration as guest.
/// 
/// Calls the [AuthService.signUpGuest] to registrate the user as guest.
/// 
/// If registration succeeds, generates a JWT token and returns it with the user id in response.
/// 
/// Returns [Response] with code `201`, [token] and [user.id] to be sent back to the client.
/// 
/// Returns [Response] with code from [CustomException] when custom error occurs.
/// 
/// Returns [Response] with code `500` when any error occurs.
Future<Response> _onPost(RequestContext context) async {
  try {
    final authService = context.read<AuthService>();

    // Registers the user.
    final user = await authService.signUpGuest();

    // Generates a JWT token.
    final token = JwtHelper.signJWT(user);

    return Response.json(
      statusCode: 201,
      body: {
        'token': token,
        'id': user.id,
      },
    );
  } on CustomException catch (e) {
    return Response(statusCode: e.code);
  } catch (e) {
    return Response(statusCode: 500);
  }
}
