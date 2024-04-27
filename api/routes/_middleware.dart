import 'package:dart_frog/dart_frog.dart';
import 'package:firedart/firedart.dart';
import 'package:uuid/v4.dart';

import '../env.dart';
import '../services/auth_service.dart';

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
