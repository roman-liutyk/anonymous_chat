import 'package:api/env/env.dart';
import 'package:api/services/auth_service.dart';
import 'package:api/services/chat_service.dart';
import 'package:api/services/user_service.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:firedart/firedart.dart';
import 'package:uuid/v4.dart';

/// Responsible for initializing [Firestore] if it is not already initialized.
///
/// Creates [provider] methods to make [AuthService], [UserService] and
/// [ChatService] accessible in our routes handlers.
Handler middleware(Handler handler) {
  if (!Firestore.initialized) {
    Firestore.initialize(Env.PROJECT_ID);
  }

  return handler
      .use(
        provider<AuthService>(
          (_) => AuthService(Firestore.instance, const UuidV4()),
        ),
      )
      .use(
        provider<UserService>(
          (_) => UserService(
            Firestore.instance,
          ),
        ),
      )
      .use(
        provider<ChatService>(
          (_) => ChatService(
            Firestore.instance,
          ),
        ),
      );
}
