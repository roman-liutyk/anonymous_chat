import 'dart:io';

import 'package:api/services/auth_service.dart';
import 'package:api/utils/jwt_helper.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.post => _onPost(context),
    _ => Future.value(
        Response(statusCode: HttpStatus.methodNotAllowed),
      ),
  };
}

Future<Response> _onPost(RequestContext context) async {
  try {
    final request = context.request;

    final body = await request.json() as Map<String, dynamic>;

    final email = body['email'] as String?;
    final password = body['password'] as String?;

    if (email == null || password == null) {
      return Response(statusCode: 401);
    }

    final authService = context.read<AuthService>();

    final user = await authService.signUp(
      email,
      password,
    );

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
