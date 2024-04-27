import 'package:anonymous_chat/domain/entities/user.dart';

class UserModel {
  const UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  final String id;
  final String username;
  final String email;
  final String password;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
    };
  }

  User toUser() {
    return User(
      id: id,
      username: username,
      email: email,
      password: password,
    );
  }

  factory UserModel.fromUser(User user) {
    return UserModel(
      id: user.id,
      username: user.username,
      email: user.email,
      password: user.password,
    );
  }
}
