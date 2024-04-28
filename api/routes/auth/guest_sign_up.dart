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
    final authService = context.read<AuthService>();

    final user = await authService.signUpGuest();

    final token = JwtHelper.signJWT(user);

    return Response.json(
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
