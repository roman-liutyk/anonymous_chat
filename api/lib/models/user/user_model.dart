enum AuthMethod {
  passwordAndEmail,
  guest,
  google,
}

abstract class UserModel {
  const UserModel({
    required this.id,
    required this.username,
    required this.authMethod,
  });


  final String id;
  final String username;
  final AuthMethod authMethod;

  Map<String, dynamic> toJson();
  
  UserModel fromJson(Map<String, dynamic> json);
}
