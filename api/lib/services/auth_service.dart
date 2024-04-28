import 'package:api/errors/custom_exception.dart';
import 'package:api/models/user/user_basic_model.dart';
import 'package:api/models/user/user_google_model.dart';
import 'package:api/models/user/user_quest_model.dart';
import 'package:firedart/firedart.dart';
import 'package:username_gen/username_gen.dart';
import 'package:uuid/v4.dart';

import '../extensions/string_extensions.dart';

/// A service class responsible for authentication-related operations.
class AuthService {
  const AuthService(
    Firestore firestore,
    UuidV4 uuid,
  )   : _firestore = firestore,
        _uuid = uuid;

  /// [_firestore] is used for database operations.
  final Firestore _firestore;

  /// [_uuid] is used to generate unique ids.
  final UuidV4 _uuid;

  /// Signs in a user using email and password.
  ///
  /// Returns a [UserBasicModel] representing user data.
  ///
  /// Throws [CustomException] with code `404` when the user does not exist.
  ///
  /// Throws [CustomException] with code `401` when provided password is incorrect.
  Future<UserBasicModel> signIn(String email, String password) async {
    final users = _firestore.collection('users');

    // All users with matching email.
    final docs = await users.where('email', isEqualTo: email).get();

    if (docs.isEmpty) {
      // Throws an exception if user does not exist.
      throw const CustomException(code: 404);
    }

    final user = UserBasicModel.fromJson(docs.first.map);

    if (password.encrypt != user.password) {
      // Throws an exception if password is incorrect.
      throw const CustomException(code: 401);
    }

    return user;
  }

  /// Signs up a new user using email and password.
  ///
  /// Generates a unique identifier and a random username for the user and encrypts the password.
  ///
  /// Saves the user data to the Firestore database.
  ///
  /// Returns a [UserBasicModel] representing just created user data.
  ///
  /// Throws [CustomException] with code `409` when the user exists.
  Future<UserBasicModel> signUp(String email, String password) async {
    final users = _firestore.collection('users');

    // Checks if users with matching email exist.
    final userExists =
        (await users.where('email', isEqualTo: email).get()).isNotEmpty;

    if (userExists) {
      // Throws an exception if user exists.
      throw const CustomException(code: 409);
    }

    // Generates user random id and username.
    final id = _uuid.generate();
    final username = UsernameGen().generate();

    // Creates user for storing with data that includes encrypted password.
    final user = UserBasicModel(
      id: id,
      username: username,
      email: email,
      password: password.encrypt,
    );

    final doc = users.document(id);

    // Saves the user data.
    await doc.set(
      user.toJson(),
    );

    return user;
  }

  /// Signs up a new user using without any credentials.
  ///
  /// Generates a unique identifier and a random username for the user.
  ///
  /// Saves the user data to the Firestore database.
  ///
  /// Returns a [UserGuestModel] representing just created user data.
  Future<UserGuestModel> signUpGuest() async {
    final users = _firestore.collection('users');

    // Generates user random id and username.
    final id = _uuid.generate();
    final username = UsernameGen().generate();

    // Creates user for storing.
    final user = UserGuestModel(
      id: id,
      username: username,
    );

    final doc = users.document(id);

    // Saves the user data.
    await doc.set(
      user.toJson(),
    );

    return user;
  }

  /// Signs up a new user using without any credentials.
  ///
  /// Generates a unique identifier and a random username for the user.
  ///
  /// Saves the user data to the Firestore database.
  ///
  /// Returns a [UserGoogleModel] representing just created or retrieved user data.
  Future<UserGoogleModel> signInGoogle(String email) async {
    final users = _firestore.collection('users');

    // All users with matching email.
    final docs = await users.where('email', isEqualTo: email).get();

    final UserGoogleModel user;

    if (docs.isNotEmpty) {
      // Returns data of already existing user.
      return UserGoogleModel.fromJson(docs.first.map);
    }

    // Generates user random id and username.
    final id = _uuid.generate();
    final username = UsernameGen().generate();

    // Creates user for storing.
    user = UserGoogleModel(
      id: id,
      username: username,
      email: email,
    );

    final doc = users.document(id);

    // Saves the user data.
    await doc.set(
      user.toJson(),
    );

    return user;
  }

  /// Deletes a user by id.
  ///
  /// Throws [CustomException] with code `404` when any error occurs.
  Future<void> deleteUserById(String id) async {
    try {
      await _firestore.collection('users').document(id).delete();
    } catch (e) {
      throw const CustomException(code: 404);
    }
  }
}
