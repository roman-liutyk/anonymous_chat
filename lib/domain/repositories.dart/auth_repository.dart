import 'package:anonymous_chat/domain/entities/user_auth_response.dart';

abstract class AuthRepository {
  Future<bool> isUserAuthorized();

  Future<UserAuthResponse> signIn({
    required String email,
    required String password,
  });

  Future<UserAuthResponse> signUp({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<void> deleteAccount();
}
