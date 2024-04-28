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

  Future<bool> signUpAsGuest();

  Future<bool> signInWithGoogle({
    required String email,
  });

  Future<void> signOut();

  Future<bool> deleteAccount({
    required String authMethod,
    required String? email,
    required String? password,
  });
}
