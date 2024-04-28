import 'package:api/models/user/user_authorized_model.dart';
import 'package:api/models/user/user_model.dart';

class UserGoogleModel extends UserAuthorizedModel {
  const UserGoogleModel({
    required String id,
    required String username,
    required String email,
    AuthMethod authMethod = AuthMethod.google,
  }) : super(
          id: id,
          username: username,
          email: email,
          authMethod: authMethod,
        );

  factory UserGoogleModel.fromJson(Map<String, dynamic> json) {
    return UserGoogleModel(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      authMethod: AuthMethod.values.firstWhere(
        (method) => method.name == json['authMethod'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'authMethod': authMethod.name,
    };
  }

  UserModel fromJson(Map<String, dynamic> json) {
    return UserGoogleModel.fromJson(json);
  }
}
