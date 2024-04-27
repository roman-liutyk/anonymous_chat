import 'package:api/env.dart';
import 'package:api/services/auth_service.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:firedart/firedart.dart';
import 'package:uuid/v4.dart';

Handler middleware(Handler handler) {
  if (!Firestore.initialized) {
    Firestore.initialize(EnvVariables.projectId);
  }

  return handler.use(
    provider<AuthService>(
      (_) => AuthService(
        Firestore.instance,
        const UuidV4(),
      ),
    ),
  );
}
