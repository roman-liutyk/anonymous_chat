import 'package:api/models/jwt_payload/jwt_payload_model.dart';

class JwtPayloadGuestModel extends JwtPayloadModel {
  const JwtPayloadGuestModel({
    required String id,
    required String username,
  }) : super(
          id: id,
          username: username,
        );

  factory JwtPayloadGuestModel.fromJson(Map<String, dynamic> json) {
    return JwtPayloadGuestModel(
      id: json['id'] as String,
      username: json['username'] as String,
    );
  }

  @override
  JwtPayloadModel fromJson(Map<String, dynamic> json) {
    return JwtPayloadGuestModel.fromJson(json);
  }
}
