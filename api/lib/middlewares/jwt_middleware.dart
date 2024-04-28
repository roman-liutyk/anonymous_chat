import 'dart:io';

import 'package:api/models/jwt_payload_model.dart';
import 'package:api/models/user_model.dart';
import 'package:api/services/auth_service.dart';
import 'package:api/services/user_service.dart';
import 'package:api/utils/jwt_helper.dart';
import 'package:dart_frog/dart_frog.dart';

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
