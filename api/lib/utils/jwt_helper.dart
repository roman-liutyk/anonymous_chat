import 'package:api/env.dart';
import 'package:api/models/jwt_payload_model.dart';
import 'package:api/models/user_model.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class JwtHelper {
  static String signJWT(UserModel user) {
    final jwt = JWT({
      'id': user.id,
      'email': user.email,
      'username': user.username,
    });

    final token = jwt.sign(
      SecretKey(
        EnvVariables.secretKey,
      ),
    );

    return token;
  }

  static JwtPayloadModel verifyJWT(String token) {
    final payload = JWT.verify(
      token,
      SecretKey(EnvVariables.secretKey),
    );

    final payloadData = payload.payload as Map<String, dynamic>;

    final model = JwtPayloadModel.fromJson(payloadData);

    return model;
  }
}
