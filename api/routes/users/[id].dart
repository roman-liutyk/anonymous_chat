import 'dart:io';

import 'package:api/extensions/string_extensions.dart';
import 'package:api/models/user/user_basic_model.dart';
import 'package:api/models/user/user_model.dart';
import 'package:api/services/auth_service.dart';
import 'package:api/services/user_service.dart';
import 'package:dart_frog/dart_frog.dart';

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

Future<Response> _onGet(RequestContext context, String id) async {
  try {
    final user = context.read<UserModel>();

    if (user.id != id) {
      return Response(statusCode: 403);
    }

    return Response.json(body: user.toJson());
  } on CustomException catch (e) {
    return Response(statusCode: e.code);
  } catch (e) {
    return Response(statusCode: 500);
  }
}

Future<Response> _onPatch(RequestContext context, String id) async {
  try {
    final user = context.read<UserModel>();

    if (user.id != id) {
      return Response(statusCode: 403);
    }

    final request = context.request;
    final body = await request.json() as Map<String, dynamic>;

    final updatedUser = await context.read<UserService>().updateUserById(id, body);

    return Response.json(
      statusCode: 200,
      body: updatedUser.toJson(),
    );
  } on CustomException catch (e) {
    return Response(statusCode: e.code); 
  } catch (e) {
    return Response(statusCode: 500);
  }
}

Future<Response> _onDelete(RequestContext context, String id) async {
  try {
    final user = context.read<UserModel>();

    if (user.id != id) {
      return Response(statusCode: 403);
    }

    final request = context.request;
    final body = await request.json() as Map<String, dynamic>;

    final password = body['password'] as String?;

    if (password == null) {
      return Response(statusCode: 400);
    }

    if (user is UserBasicModel && user.password != password.encrypt) {
      return Response(statusCode: 403);
    }

    final authService = context.read<AuthService>();

    authService.deleteUserById(user.id);

    return Response(statusCode: 200);
  } on CustomException catch (e) {
    return Response(statusCode: e.code);
  } catch (e) {
    return Response(statusCode: 500);
  }
}
