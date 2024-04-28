import 'package:api/models/user/user_model.dart';

class UserGuestModel extends UserModel {
  const UserGuestModel({
    required String id,
    required String username,
    AuthMethod authMethod = AuthMethod.guest,
  }) : super(
          id: id,
          username: username,
          authMethod: authMethod,
        );

  factory UserGuestModel.fromJson(Map<String, dynamic> json) {
    return UserGuestModel(
      id: json['id'] as String,
      username: json['username'] as String,
      authMethod: AuthMethod.values.firstWhere(
        (method) => method.name == json['authMethod'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'authMethod': authMethod.name,
    };
  }

  UserModel fromJson(Map<String, dynamic> json) {
    return UserGuestModel.fromJson(json);
  }
}
