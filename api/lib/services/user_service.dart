import 'package:api/models/user/user_basic_model.dart';
import 'package:api/models/user/user_google_model.dart';
import 'package:api/models/user/user_model.dart';
import 'package:api/services/auth_service.dart';
import 'package:firedart/firedart.dart';

class UserService {
  const UserService(this._firestore);

  final Firestore _firestore;

  Future<UserModel> fetchUserById(String id) async {
    try {
      final doc = await _firestore.collection('users').document(id).get();

      return _getUserFromJson(doc.map);
    } catch (e) {
      throw const CustomException(code: 404);
    }
  }

  Future<UserModel> updateUserById(
    String id,
    Map<String, dynamic> map,
  ) async {
    try {
      await _firestore.collection('users').document(id).update(map);

      final doc = await _firestore.collection('users').document(id).get();

      return _getUserFromJson(doc.map);
    } catch (e) {
      throw const CustomException(code: 403);
    }
  }

  UserModel _getUserFromJson(Map<String, dynamic> json) {
    final UserModel user;

    if (!json.containsKey('authMethod')) {
      throw const CustomException(code: 400);
    }

    final AuthMethod authMethod = AuthMethod.values.firstWhere(
      (method) => method.name == json['authMethod'],
    );

    switch (authMethod) {
      case AuthMethod.passwordAndEmail:
        user = UserBasicModel.fromJson(json);
        break;
      case AuthMethod.google:
        user = UserGoogleModel.fromJson(json);
        break;
      case AuthMethod.guest:
        user = UserGoogleModel.fromJson(json);
        break;
    }

    return user;
  }
}
