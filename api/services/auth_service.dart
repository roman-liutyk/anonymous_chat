import 'package:firedart/firedart.dart';
import 'package:username_gen/username_gen.dart';
import 'package:uuid/v4.dart';

import '../extensions/string_extensions.dart';
import '../models/user_model.dart';

class AuthService {
  const AuthService(
    this._firestore,
    this._uuid,
  );

  final Firestore _firestore;
  final UuidV4 _uuid;

  Future<UserModel> signIn(String email, String password) async {
    final users = _firestore.collection('users');

    final docs = await users.where('email', isEqualTo: email).get();

    if (docs.isEmpty) {
      throw const AuthException(code: 404);
    }

    final user = UserModel.fromJson(docs.first.map);

    if (password.encrypt != user.password) {
      throw const AuthException(code: 401);
    }

    return user;
  }

  Future<UserModel> signUp(String email, String password) async {
    final users = _firestore.collection('users');

    final userExists =
        (await users.where('email', isEqualTo: email).get()).isNotEmpty;

    if (userExists) {
      throw const AuthException(code: 409);
    }

    final id = _uuid.generate();
    final username = UsernameGen().generate();

    final user = UserModel(
      id: id,
      username: username,
      email: email,
      password: password.encrypt,
    );

    final doc = users.document(id);

    await doc.set(
      user.toJson(),
    );

    return user;
  }
}

class AuthException implements Exception {
  const AuthException({required this.code});

  final int code;
}
