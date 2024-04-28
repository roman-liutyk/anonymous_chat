import 'package:api/models/user/user_authorized_model.dart';
import 'package:api/models/user/user_model.dart';

class UserBasicModel extends UserAuthorizedModel {
  const UserBasicModel({
    required String id,
    required String username,
    required String email,
    required this.password,
    AuthMethod authMethod = AuthMethod.passwordAndEmail,
  }) : super(
          id: id,
          username: username,
          email: email,
          authMethod: authMethod,
        );

  final String password;

  factory UserBasicModel.fromJson(Map<String, dynamic> json) {
    return UserBasicModel(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
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
      'password': password,
      'authMethod': authMethod.name,
    };
  }

  UserModel fromJson(Map<String, dynamic> json) {
    return UserBasicModel.fromJson(json);
  }
}
