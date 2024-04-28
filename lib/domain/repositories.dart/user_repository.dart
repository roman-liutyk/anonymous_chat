import 'package:anonymous_chat/domain/entities/user/user.dart';

abstract class UserRepository {

  void clearCurrentUser();
  
  Future<User> getCurrentUser();
  
  Future<User> updateUserData({
    required String username,
    required String email,
  });
}
