import 'dart:convert';
import 'package:anonymous_chat/core/app_constants.dart';
import 'package:anonymous_chat/core/erorrs/auth_exception.dart';
import 'package:anonymous_chat/core/erorrs/user_exception.dart';
import 'package:anonymous_chat/core/services/secure_storage_service.dart';
import 'package:anonymous_chat/data/models/user_auth_response_model.dart';
import 'package:anonymous_chat/domain/repositories.dart/auth_repository.dart';
import 'package:http/http.dart';

class ApiAuthRepository implements AuthRepository {
  ApiAuthRepository({
    required Client client,
    required SecureSotrageService secureStorage,
  })  : _client = client,
        _secureStorage = secureStorage;

  final Client _client;
  final SecureSotrageService _secureStorage;

  String? _userToken;
  String? _userId;

  @override
  Future<bool> isUserAuthorized() async {
    _userToken ??= await _secureStorage.getUserToken();
    _userId ??= await _secureStorage.getUserId();

    if (_userToken != null && _userId != null) {
      return Future.value(true);
    }

    return false;
  }

  @override
  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final uri = Uri.http(
        AppConstants.host,
        AppConstants.signInPath,
      );

      final Response response = await _client.post(
        uri,
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      switch (response.statusCode) {
        case 200:
          final UserAuthResponse userAuthResponse = UserAuthResponse.fromJson(
            jsonDecode(response.body),
          );

          await _secureStorage.setUserId(userId: userAuthResponse.id);
          await _secureStorage.setUserToken(userToken: userAuthResponse.token);
          return true;
        case 401:
          throw AuthExceptionWrongPassword();
        case 404:
          throw AuthExceptionUserDoesNotExist();
        default:
          throw AuthException();
      }
    } catch (exception) {
      rethrow;
    }
  }

  @override
  Future<bool> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final uri = Uri.http(
        AppConstants.host,
        AppConstants.signUpPath,
      );

      final Response response = await _client.post(
        uri,
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      switch (response.statusCode) {
        case 201:
          final UserAuthResponse userAuthResponse = UserAuthResponse.fromJson(
            jsonDecode(response.body),
          );

          await _secureStorage.setUserId(userId: userAuthResponse.id);
          await _secureStorage.setUserToken(userToken: userAuthResponse.token);
          return true;
        case 409:
          throw AuthExceptionUserAlreadyExists();
        default:
          throw AuthException();
      }
    } catch (exception) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await _secureStorage.clearAllData();
  }

  @override
  Future<bool> deleteAccount({
    required String password,
  }) async {
    try {
      final id = await _secureStorage.getUserId();
      final token = await _secureStorage.getUserToken();

      final uri = Uri.http(
        AppConstants.host,
        '${AppConstants.usersPath}$id',
      );

      final Response response = await _client.delete(
        headers: {'authorization': token ?? ''},
        uri,
        body: jsonEncode({
          'password': password,
        }),
      );

      switch (response.statusCode) {
        case 200:
          await _secureStorage.clearAllData();
          return true;
        case 400:
          throw AuthExceptionAccountDeletingWithWrongCredentials();
        case 401:
          throw UserExceptionUnathorizedRequestToUserData();
        case 403:
          throw AuthExceptionAccountDeletingWithWrongCredentials();
        default:
          throw AuthExceptionAccountDeleting();
      }
    } catch (exception) {
      rethrow;
    }
  }
}
