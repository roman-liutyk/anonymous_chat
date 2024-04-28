abstract class JwtPayloadModel {
  const JwtPayloadModel({
    required this.id,
    required this.username,
  });

  final String id;
  final String username;

  JwtPayloadModel fromJson(Map<String, dynamic> json);
}
