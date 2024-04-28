import 'package:api/models/jwt_payload/jwt_payload_model.dart';

/// Guest user payload model that extends [JwtPayloadModel] and implements
/// needed methods.
class JwtPayloadGuestModel extends JwtPayloadModel {
  const JwtPayloadGuestModel({
    required String id,
    required String username,
  }) : super(
          id: id,
          username: username,
        );

  /// Factory constructor that recieves JSON in the parameters and creates the
  /// instance of [JwtPayloadGuestModel].
  ///
  /// Creating the instance is done by assigning the certain value from JSON to
  /// certain field parameter in [JwtPayloadGuestModel].
  factory JwtPayloadGuestModel.fromJson(Map<String, dynamic> json) {
    return JwtPayloadGuestModel(
      id: json['id'] as String,
      username: json['username'] as String,
    );
  }

  /// Calls factory [fromJson] constructor.
  @override
  JwtPayloadModel fromJson(Map<String, dynamic> json) {
    return JwtPayloadGuestModel.fromJson(json);
  }
}
