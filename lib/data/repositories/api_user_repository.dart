import 'dart:convert';

import 'package:anonymous_chat/core/app_constants.dart';
import 'package:anonymous_chat/core/erorrs/user_exception.dart';
import 'package:anonymous_chat/core/services/secure_storage_service.dart';
import 'package:anonymous_chat/data/models/user_model.dart';
import 'package:anonymous_chat/domain/entities/user.dart';
import 'package:anonymous_chat/domain/repositories.dart/user_repository.dart';
import 'package:http/http.dart';

class ApiUserRepository implements UserRepository {
  ApiUserRepository({
    required Client client,
    required SecureSotrageService secureStorage,
  })  : _client = client,
        _secureStorage = secureStorage;

  final Client _client;
  final SecureSotrageService _secureStorage;

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

    try {
      final id = await _secureStorage.getUserId();
      final token = await _secureStorage.getUserToken();

      final uri = Uri.http(
        AppConstants.host,
        '${AppConstants.usersPath}$id',
      );

      final Response response = await _client.get(
        headers: {'authorization': token ?? ''},
        uri,
      );

      switch (response.statusCode) {
        case 200:
          final UserModel userModel = UserModel.fromJson(
            jsonDecode(response.body),
          );

          _currentUser = userModel.toUser();

          return _currentUser!;
        case 401:
          throw UserExceptionUnathorizedRequestToUserData();
        case 403:
          throw UserExceptionForbiddenRequestToDataUser();
        default:
          throw UserExceptionDataRetrieving();
      }
    } catch (exception) {
      rethrow;
    }
  }

  @override
  Future<User> updateUserData({
    required String username,
    required String email,
  }) async {
    try {
      final id = await _secureStorage.getUserId();
      final token = await _secureStorage.getUserToken();

      final uri = Uri.http(
        AppConstants.host,
        '${AppConstants.usersPath}$id',
      );

      final Response response = await _client.patch(
        headers: {'authorization': token ?? ''},
        uri,
        body: jsonEncode({
          'username': username,
          'email': email,
        }),
      );

      switch (response.statusCode) {
        case 200:
          final UserModel userModel = UserModel.fromJson(
            jsonDecode(response.body),
          );

          _currentUser = userModel.toUser();

          return _currentUser!;
        default:
          throw UserExceptionDataUpdating();
      }
    } catch (exception) {
      rethrow;
    }
  }
}
