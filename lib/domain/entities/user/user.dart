enum AuthMethod {
  passwordAndEmail,
  guest,
  google;

  @override
  String toString() => name;
}

abstract class User {
  const User({
    required this.id,
    required this.username,
    required this.authMethod,
  });

  final String id;
  final String username;
  final AuthMethod authMethod;
}
