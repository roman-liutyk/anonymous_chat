import 'package:anonymous_chat/domain/entities/user.dart';

abstract class UserRepository {

  void clearCurrentUser();
  
  Future<User> getCurrentUser();
  
  Future<void> updateUserData({
    required String username,
    required String email,
  });
}
