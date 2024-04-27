import 'dart:convert';
import 'package:anonymous_chat/core/app_constants.dart';
import 'package:anonymous_chat/core/erorrs/auth_exception.dart';
import 'package:anonymous_chat/core/services/secure_storage_service.dart';
import 'package:anonymous_chat/domain/entities/user_auth_response.dart';
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
  Future<UserAuthResponse> signIn({
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

      switch(response.statusCode) {
        case 200:
          final UserAuthResponse userAuthResponse = UserAuthResponse.fromJson(
            jsonDecode(response.body),
          );

          await _secureStorage.setUserId(userId: userAuthResponse.id);
          await _secureStorage.setUserToken(userToken: userAuthResponse.token);
          return userAuthResponse;
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
  Future<UserAuthResponse> signUp({
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

      switch(response.statusCode) {
        case 201:
          final UserAuthResponse userAuthResponse = UserAuthResponse.fromJson(
            jsonDecode(response.body),
          );

          await _secureStorage.setUserId(userId: userAuthResponse.id);
          await _secureStorage.setUserToken(userToken: userAuthResponse.token);
          return userAuthResponse;
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
  Future<void> deleteAccount() async {
    await _secureStorage.clearAllData();

    // TODO: implement deleteUser
    throw UnimplementedError();
  }
}
