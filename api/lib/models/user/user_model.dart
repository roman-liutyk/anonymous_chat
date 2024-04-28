/// Enum that contains authetication methods such as [passwordAndEmail], [guest]
///  and [google].
enum AuthMethod {
  passwordAndEmail,
  guest,
  google,
}

/// Abstract model that contains general fields for further inheritance.
abstract class UserModel {
  const UserModel({
    required this.id,
    required this.username,
    required this.authMethod,
  });

  /// `id` - identifier for user in the database.
  final String id;

  /// `username` -  user's username.
  final String username;

  /// `authMethod` - enum value of the authetication method.
  final AuthMethod authMethod;

  /// Declaration of the converting user to JSON method.
  Map<String, dynamic> toJson();

  /// Declaration of the converting JSON to user method.
  UserModel fromJson(Map<String, dynamic> json);
}
