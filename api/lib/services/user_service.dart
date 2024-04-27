import 'package:api/models/user_model.dart';
import 'package:api/services/auth_service.dart';
import 'package:firedart/firedart.dart';

class UserService {
  const UserService(this._firestore);

  final Firestore _firestore;

  Future<UserModel> fetchUserById(String id) async {
    try {
      print(1);

      final c = await _firestore.collection('users').get();

      print(c.map((element) => element.map));

      final doc = await _firestore.collection('users').document(id).get();

      return UserModel.fromJson(doc.map);
    } catch (e) {
      throw const CustomException(code: 404);
    }
  }
}
