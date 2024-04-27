import 'package:api/services/auth_service.dart';
import 'package:api/services/user_service.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(
  RequestContext context,
  String id,
) async {
  try {
    final user = await context.read<UserService>().fetchUserById(id);

    return Response.json(body: user.toJson());
  } on CustomException catch (e) {
    return Response(statusCode: e.code);
  } catch (e) {
    return Response(statusCode: 500);
  }
}
