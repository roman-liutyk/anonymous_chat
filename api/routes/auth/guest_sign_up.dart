import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  return Future.value(
    Response(statusCode: HttpStatus.methodNotAllowed),
  );
}
