import 'package:anonymous_chat/domain/entities/user/user.dart';
import 'package:anonymous_chat/domain/entities/user/user_basic.dart';
import 'package:anonymous_chat/domain/entities/user/user_google.dart';
import 'package:anonymous_chat/domain/entities/user/user_guest.dart';

class UserModel {
  const UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.authMethod,
  });

  final String id;
  final String username;
  final AuthMethod authMethod;
  final String? email;
  final String? password;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String?,
      password: json['password'] as String?,
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
      'authMethod': authMethod,
    };
  }

  User toUser() {
    switch (authMethod) {
      case AuthMethod.passwordAndEmail:
        return UserBasic(
          id: id,
          username: username,
          authMethod: authMethod,
          email: email!,
          password: password!,
        );
      case AuthMethod.google:
        return UserGoogle(
          id: id,
          username: username,
          authMethod: authMethod,
          email: email!,
        );
      case AuthMethod.guest:
        return UserGuest(
          id: id,
          username: username,
          authMethod: authMethod,
        );
    }
  }

  factory UserModel.fromUser(User user) {
    String? email;
    String? password;

    if (user is UserBasic) {
      email = (user).email;
      password = (user).password;
    } else if (user is UserGoogle) {
      email = (user).email;
    }

    return UserModel(
      id: user.id,
      username: user.username,
      email: email,
      password: password,
      authMethod: user.authMethod,
    );
  }
}
