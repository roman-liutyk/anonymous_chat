import 'package:anonymous_chat/domain/entities/user.dart';
import 'package:anonymous_chat/domain/repositories.dart/user_repository.dart';
import 'package:http/http.dart';

class ApiUserRepository implements UserRepository {
  ApiUserRepository({
    required Client client,
  })  : _client = client;

  final Client _client;

  User? _currentUser;
  
  @override
  void clearCurrentUser() {
    _currentUser = null;
  }

  @override
  Future<User> getCurrentUser() async {
    if (_currentUser != null) {
      return Future.value(_currentUser);
    }

    /// TODO implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<void> updateUserData({
    required String username,
    required String email,
  }) async {
    // TODO: implement updateUserData
    throw UnimplementedError();
  }
}