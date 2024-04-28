import 'package:api/models/jwt_payload/jwt_payload_model.dart';

/// Authorized user payload model that extends [JwtPayloadModel] and implements
/// needed methods.
class JwtPayloadAuthorizedModel extends JwtPayloadModel {
  const JwtPayloadAuthorizedModel({
    required String id,
    required String username,
    required this.email,
  }) : super(
          id: id,
          username: username,
        );

  /// `email` - user email retrieved from JWT token.
  final String email;

  /// Factory constructor that recieves JSON in the parameters and creates the
  /// instance of [JwtPayloadAuthorizedModel].
  ///
  /// Creating the instance is done by assigning the certain value from JSON to
  /// certain field parameter in [JwtPayloadAuthorizedModel].
  factory JwtPayloadAuthorizedModel.fromJson(Map<String, dynamic> json) {
    return JwtPayloadAuthorizedModel(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
    );
  }

  /// Calls factory [fromJson] constructor.
  @override
  JwtPayloadModel fromJson(Map<String, dynamic> json) {
    return JwtPayloadAuthorizedModel.fromJson(json);
  }
}
