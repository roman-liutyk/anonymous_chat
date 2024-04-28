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
///  Returns [Response] representing the response to be sent back to the client.
Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.post => _onPost(context),
    _ => Future.value(
        Response(statusCode: HttpStatus.methodNotAllowed),
      ),
  };
}

/// Handles POST requests for user registration.
///
/// Parses the request body to extract email and password.
/// 
/// Calls the [AuthService.signUp] to registrate the user.
/// 
/// If registration succeeds, generates a JWT token and returns it with the user id in response.
/// 
/// Returns [Response] with code `201`, [token] and [user.id] to be sent back to the client.
/// 
/// Returns [Response] with code `401` when credentials for registration were not provided.
/// 
/// Returns [Response] with code from [CustomException] when custom error occurs.
/// 
/// Returns [Response] with code `500` when any other error occurs.
Future<Response> _onPost(RequestContext context) async {
  try {
    // Parses the request body to extract email and password.
    final request = context.request;
    final body = await request.json() as Map<String, dynamic>;

    final email = body['email'] as String?;
    final password = body['password'] as String?;

    if (email == null || password == null) {
      // Returns a response with failure if credentials for registration were not provided.
      return Response(statusCode: 401);
    }

    final authService = context.read<AuthService>();

    // Registers the user.
    final user = await authService.signUp(
      email,
      password,
    );

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
