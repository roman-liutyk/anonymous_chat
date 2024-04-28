import 'package:api/errors/custom_exception.dart';
import 'package:api/models/user/user_basic_model.dart';
import 'package:api/models/user/user_google_model.dart';
import 'package:api/models/user/user_model.dart';
import 'package:api/models/user/user_quest_model.dart';
import 'package:firedart/firedart.dart';

/// A service class responsible for user-related operations.
class UserService {
  const UserService(this._firestore);

  /// [_firestore] is used for database operations.
  final Firestore _firestore;

  /// Fetches a user data by id from database.
  ///
  /// Converts a fetched JSON data into a [UserModel] and then returns [UserModel].
  ///
  /// Throws [CustomException] with code `404` when any error occurs.
  Future<UserModel> fetchUserById(String id) async {
    try {
      final doc = await _firestore.collection('users').document(id).get();

      return _getUserFromJson(doc.map);
    } catch (e) {
      throw const CustomException(code: 404);
    }
  }

  /// Updates a user data by id in database.
  ///
  /// Replaces/updates data that is provided as [map].
  ///
  /// Fetches just updated user data , converts JSON data into a [UserModel] and then returns [UserModel].
  ///
  /// Throws [CustomException] with code `403` when any error occurs.
  Future<UserModel> updateUserById(String id, Map<String, dynamic> map) async {
    try {
      await _firestore.collection('users').document(id).update(map);

      final doc = await _firestore.collection('users').document(id).get();

      return _getUserFromJson(doc.map);
    } catch (e) {
      throw const CustomException(code: 403);
    }
  }

  /// Converts JSON data into a [UserBasicModel] if user registered with email and password.
  ///
  /// Converts JSON data into a [UserGoogleModel] if user registered with Google account.
  ///
  /// Converts JSON data into a [UserGuestModel] if user registered as a guest.
  ///
  /// Throws [CustomException] with code `400` when [json] does not have value for `authMethod`.
  UserModel _getUserFromJson(Map<String, dynamic> json) {
    final UserModel user;

    if (!json.containsKey('authMethod')) {
      throw const CustomException(code: 400);
    }

    final AuthMethod authMethod = AuthMethod.values.firstWhere(
      (method) => method.name == json['authMethod'],
    );

    // Converts JSON data into a UserModel according to authentification method.
    switch (authMethod) {
      case AuthMethod.passwordAndEmail:
        user = UserBasicModel.fromJson(json);
        break;
      case AuthMethod.google:
        user = UserGoogleModel.fromJson(json);
        break;
      case AuthMethod.guest:
        user = UserGuestModel.fromJson(json);
        break;
    }

    return user;
  }
}
