abstract class AuthRepository {
  Future<String> signIn({
    required String email,
    required String password,
  });

  Future<String> signUp({
    required String email,
    required String password,
  });

  Future<void> deleteUser();

  Future<void> updateUserData({
    required String username,
    required String email,
  });
}
