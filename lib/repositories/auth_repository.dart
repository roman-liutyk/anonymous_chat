import 'dart:convert';
import 'dart:developer';

// import 'package:dio/dio.dart';
import 'package:http/http.dart';

class AuthRepository {
  // AuthRepository({
  //   required Client client,
  // }) : _client = client;

  // final Client _client;

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final uri = Uri.http(
        '10.0.2.2:8080',
        '/auth/sign_in',
      );
      // final uri = Uri.http('localhost:8080', '/auth/sign_in');

      final Response response = await Client().post(
        uri,
        body: jsonEncode({
          "email": "email@domain.com",
          "password": "12345678",
        }),
      );

      log(response.body);
      // final dio = Dio();
      // final response = await dio.get(
      //   'http://localhost:8080/auth/sign_in',
      //   data: {
      //     'email': 'email@domain.com',
      //     'password': '12345678',
      //   },
      // );
      // log(response.data);
    } catch (e) {
      log('Error $e');
    }
  }
}
