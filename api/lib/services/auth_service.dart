import 'package:api/models/user/user_basic_model.dart';
import 'package:api/models/user/user_google_model.dart';
import 'package:api/models/user/user_quest_model.dart';
import 'package:firedart/firedart.dart';
import 'package:username_gen/username_gen.dart';
import 'package:uuid/v4.dart';

import '../extensions/string_extensions.dart';

class AuthService {
  const AuthService(
    this._firestore,
    this._uuid,
  );

  final Firestore _firestore;
  final UuidV4 _uuid;

  Future<UserBasicModel> signIn(String email, String password) async {
    final users = _firestore.collection('users');

    final docs = await users.where('email', isEqualTo: email).get();

    if (docs.isEmpty) {
      throw const CustomException(code: 404);
    }

    final user = UserBasicModel.fromJson(docs.first.map);

    if (password.encrypt != user.password) {
      throw const CustomException(code: 401);
    }

    return user;
  }

  Future<UserBasicModel> signUp(String email, String password) async {
    final users = _firestore.collection('users');

    final userExists =
        (await users.where('email', isEqualTo: email).get()).isNotEmpty;

    if (userExists) {
      throw const CustomException(code: 409);
    }

    final id = _uuid.generate();
    final username = UsernameGen().generate();

    final user = UserBasicModel(
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

  Future<UserGuestModel> signUpGuest() async {
    final users = _firestore.collection('users');

    final id = _uuid.generate();
    final username = UsernameGen().generate();

    final user = UserGuestModel(
      id: id,
      username: username,
    );

    final doc = users.document(id);

    await doc.set(
      user.toJson(),
    );

    return user;
  }

  Future<UserGoogleModel> signInGoogle(String email) async {
    final users = _firestore.collection('users');
    final docs = await users.where('email', isEqualTo: email).get();

    final UserGoogleModel user;

    if (docs.isNotEmpty) {
      return UserGoogleModel.fromJson(docs.first.map);
    }

    final id = _uuid.generate();
    final username = UsernameGen().generate();

    user = UserGoogleModel(
      id: id,
      username: username,
      email: email
    );

    final doc = users.document(id);

    await doc.set(
      user.toJson(),
    );

    return user;
  }

  Future<void> deleteUserById(String id) async {
    try {
      await _firestore.collection('users').document(id).delete();
    } catch (e) {
      throw const CustomException(code: 404);
    }
  }
}

class CustomException implements Exception {
  const CustomException({required this.code});

  final int code;
}
