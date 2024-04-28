import 'dart:io';

import 'package:api/errors/custom_exception.dart';
import 'package:api/extensions/string_extensions.dart';
import 'package:api/models/user/user_basic_model.dart';
import 'package:api/models/user/user_model.dart';
import 'package:api/services/auth_service.dart';
import 'package:api/services/user_service.dart';
import 'package:dart_frog/dart_frog.dart';

/// Handles incoming HTTP requests and returns appropriate responses.
///
/// Successful response can be returned onfy for GET, PATCH and DELETE request.
/// For all other request will be returned status [HttpStatus.methodNotAllowed].
///
/// [context] represents the request context containing the request details.
///
/// Returns a Future [Response] representing the response to be sent back to the client.
///
/// Returns [Response] with code `500` when not custom error occurs.
///
/// Returns [Response] with code from [CustomException] when custom error occurs.
Future<Response> onRequest(
  RequestContext context,
  String id,
) async {
  try {
    return switch (context.request.method) {
      HttpMethod.get => _onGet(context, id),
      HttpMethod.patch => _onPatch(context, id),
      HttpMethod.delete => _onDelete(context, id),
      _ => Future.value(
          Response(statusCode: HttpStatus.methodNotAllowed),
        ),
    };
  } on CustomException catch (e) {
    return Response(statusCode: e.code);
  } catch (e) {
    return Response(statusCode: 500);
  }
}

/// Handles GET requests for user retrieving.
///
/// If JWT token was verified, user is fetched by id from this token and then can be accessed with provider.
///
/// Returns [Response] with code `200` and used data to be sent back to the client.
///
/// Returns [Response] with code `403` when an attempt to request another user data appeares.
///
/// Returns [Response] with code from [CustomException] when custom error occurs.
///
/// Returns [Response] with code `500` when any error occurs.
Future<Response> _onGet(RequestContext context, String id) async {
  try {
    final user = context.read<UserModel>();

    if (user.id != id) {
      // Returns a response with failure if client attempts to request another user data.
      return Response(statusCode: 403);
    }

    return Response.json(body: user.toJson());
  } on CustomException catch (e) {
    return Response(statusCode: e.code);
  } catch (e) {
    return Response(statusCode: 500);
  }
}

/// Handles PATCH requests for user retrieving.
///
/// Parses the request body to extract data to update.
///
/// If JWT token was verified, user is fetched by id from this token and then can be accessed with provider.
///
/// Calls the [UserService.updateUserById] to update user data by id.
///
/// Returns [Response] with code `201` and used data to be sent back to the client.
///
/// Returns [Response] with code `403` when an attempt to request another user data appeares.
///
/// Returns [Response] with code from [CustomException] when custom error occurs.
///
/// Returns [Response] with code `500` when any error occurs.
Future<Response> _onPatch(RequestContext context, String id) async {
  try {
    final user = context.read<UserModel>();

    if (user.id != id) {
      // Returns a response with failure if client attempts to request another user data.
      return Response(statusCode: 403);
    }

    // Parses the request body to extract data to update.
    final request = context.request;
    final body = await request.json() as Map<String, dynamic>;

    // Updates user data.
    final updatedUser =
        await context.read<UserService>().updateUserById(id, body);

    return Response.json(
      statusCode: 201,
      body: updatedUser.toJson(),
    );
  } on CustomException catch (e) {
    return Response(statusCode: e.code);
  } catch (e) {
    return Response(statusCode: 500);
  }
}

/// Handles DELETE requests for user deleting.
///
/// Parses the request body to extract data to delete user.
///
/// If JWT token was verified, user is fetched by id from this token and then can be accessed with provider.
///
/// Calls the [UserService.updateUserById] to update user data by id.
///
/// Returns [Response] with code `200` when deletion as successful.
///
/// Returns [Response] with code `403` when an attempt to request another user data appeares.
///
/// Returns [Response] with code `400` when [authMethod] was not provided.
///
/// Returns [Response] with code `400` when [authMethod] is [AuthMethod.passwordAndEmail] but [password] was not provided.
///
/// Returns [Response] with code `400` when [authMethod] is [AuthMethod.google] but [email] was not provided.
///
/// Returns [Response] with code `403` when [authMethod] is [AuthMethod.passwordAndEmail] but [password] is incorrect.
///
/// Returns [Response] with code from [CustomException] when custom error occurs.
///
/// Returns [Response] with code `500` when any error occurs.
Future<Response> _onDelete(RequestContext context, String id) async {
  try {
    final user = context.read<UserModel>();

    if (user.id != id) {
      // Returns a response with failure if client attempts to request another user data.
      return Response(statusCode: 403);
    }

    // Parses the request body to extract data for deletion right confirmation.
    final request = context.request;
    final body = await request.json() as Map<String, dynamic>;

    final authMethod = body['authMethod'] as String?;
    final password = body['password'] as String?;
    final email = body['email'] as String?;

    if (authMethod == null) {
      // Returns a response with failure if client made request without `authMethod`.
      return Response(statusCode: 400);
    }

    if (authMethod == AuthMethod.passwordAndEmail.name && password == null) {
      // Returns a response with failure if client made request with `authMethod` that represents 
      //authentication with email and password but without `password`.
      return Response(statusCode: 400);
    } else if (authMethod == AuthMethod.passwordAndEmail.name &&
        user is UserBasicModel &&
        user.password != password!.encrypt) {
      // Returns a response with failure if client made request with `authMethod` that represents 
      //authentication with email and password but `password` is incorrect.
      return Response(statusCode: 403);
    }

    if (authMethod == AuthMethod.google.name && email == null) {
      // Returns a response with failure if client made request with `authMethod` that represents 
      //authentication with google but without `password`.
      return Response(statusCode: 400);
    }

    final authService = context.read<AuthService>();

    // Deletes user.
    authService.deleteUserById(user.id);

    return Response(statusCode: 200);
  } on CustomException catch (e) {
    return Response(statusCode: e.code);
  } catch (e) {
    return Response(statusCode: 500);
  }
}
