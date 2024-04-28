/// Abstract model for the JWT payload data that is decrypted from JWT token.
abstract class JwtPayloadModel {
  const JwtPayloadModel({
    required this.id,
    required this.username,
  });

  /// `id` - user identifier in the database.
  final String id;

  /// `username` - user username that is auto-generated.
  final String username;

  /// Declaration of the JSON convertion method.
  JwtPayloadModel fromJson(Map<String, dynamic> json);
}
