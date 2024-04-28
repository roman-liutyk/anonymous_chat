abstract class AuthRepository {
  Future<bool> isUserAuthorized();

  Future<bool> signIn({
    required String email,
    required String password,
  });

  Future<bool> signUp({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<bool> deleteAccount({
    required String password,
  });
}
