import 'package:api/models/jwt_payload/jwt_payload_model.dart';

class JwtPayloadAuthorizedModel extends JwtPayloadModel {
  const JwtPayloadAuthorizedModel({
    required String id,
    required String username,
    required this.email,
  }) : super(
          id: id,
          username: username,
        );

  final String email;

  factory JwtPayloadAuthorizedModel.fromJson(Map<String, dynamic> json) {
    return JwtPayloadAuthorizedModel(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
    );
  }
  
  @override
  JwtPayloadModel fromJson(Map<String, dynamic> json) {
    return JwtPayloadAuthorizedModel.fromJson(json);
  }
}
