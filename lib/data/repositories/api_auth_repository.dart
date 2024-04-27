import 'dart:convert';
import 'package:anonymous_chat/domain/repositories.dart/auth_repository.dart';
import 'package:http/http.dart';

class ApiAuthRepository implements AuthRepository {
  ApiAuthRepository({
    required Client client,
  }) : _client = client;

  final Client _client;
  final String _host = '10.0.2.2:8080';
  final String _signInPath = '/auth/sign_in';
  final String _signUpPath = '/auth/sign_up';

  @override
  Future<String> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final uri = Uri.http(
        _host,
        _signInPath,
      );

      final Response response = await _client.post(
        uri,
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['token'];
      }

      throw Exception('wrong status code');
    } catch (exception) {
      throw Exception(exception);
    }
  }

  @override
  Future<String> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final uri = Uri.http(
        _host,
        _signUpPath,
      );

      final Response response = await _client.post(
        uri,
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['token'];
      }

      throw Exception('wrong status code');
    } catch (exception) {
      throw Exception(exception);
    }
  }

  @override
  Future<void> deleteUser() {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<void> updateUserData({
    required String username,
    required String email,
  }) {
    // TODO: implement updateUserData
    throw UnimplementedError();
  }
}
