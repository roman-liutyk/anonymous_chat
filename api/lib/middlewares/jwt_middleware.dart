import 'dart:io';

import 'package:api/models/jwt_payload/jwt_payload_model.dart';
import 'package:api/models/user/user_model.dart';
import 'package:api/services/auth_service.dart';
import 'package:api/services/user_service.dart';
import 'package:api/utils/jwt_helper.dart';
import 'package:dart_frog/dart_frog.dart';

/// Verifies JWT token retrieved from `headers` of every request handled under of
/// this `middleware`.
///
/// If token is empty it returns response with `401` status
/// code.
///
/// If token is present in `headers`, the [JwtPayloadModel] is retrieved
/// from [JwtHelper.verifyJWT] helper method.
///
/// Then the user existence is checked and [UserModel] added to ther provider
/// so we can access the user inside our `routes`.
///
/// Catches [CustomException] and returns [Response] with certain status code.
Handler JWTMiddleware(Handler handler) {
  return (context) async {
    try {
      final request = context.request;
      final authHeader = request.headers[HttpHeaders.authorizationHeader] ?? '';
      final token = authHeader.replaceFirst('Bearer ', '');

      if (token.isEmpty) throw const CustomException(code: 401);

      final JwtPayloadModel payload = JwtHelper.verifyJWT(token);

      final userService = context.read<UserService>();

      final user = await userService.fetchUserById(payload.id);

      final updatedContext = context.provide<UserModel>(() => user);

      return handler(updatedContext);
    } on CustomException catch (e) {
      return Response(statusCode: e.code);
    } catch (e) {
      return Response(statusCode: 500);
    }
  };
}
