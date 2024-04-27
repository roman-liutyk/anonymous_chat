import 'dart:developer';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import '../../env.dart';
import '../../services/auth_service.dart';

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
    final body = await context.request.json() as Map<String, dynamic>;
    log(body.toString());

    final authService = context.read<AuthService>();

    final user = await authService.signIn(
      body['email'] as String,
      body['password'] as String,
    );

    final jwt = JWT({
      'id': user.id,
      'email': user.email,
      'username': user.username,
    });

    final token = jwt.sign(
      SecretKey(
        EnvVariables.secretKey,
      ),
    );

    return Response.json(
      body: {'token': token},
    );
  } on AuthException catch (e) {
    return Response(statusCode: e.code);
  } catch (e) {
    return Response(statusCode: 500);
  }
}
