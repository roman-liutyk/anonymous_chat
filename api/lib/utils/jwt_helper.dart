import 'package:api/env.dart';
import 'package:api/models/jwt_payload/jwt_payload_authorized_model.dart';
import 'package:api/models/jwt_payload/jwt_payload_guest_model.dart';
import 'package:api/models/jwt_payload/jwt_payload_model.dart';
import 'package:api/models/user/user_authorized_model.dart';
import 'package:api/models/user/user_model.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class JwtHelper {
  static String signJWT(UserModel user) {
    final JWT jwt;

    if (user is UserAuthorizedModel) {
      jwt = JWT({
        'id': user.id,
        'email': user.email,
        'username': user.username,
      });
    } else {
      jwt = JWT({
        'id': user.id,
        'username': user.username,
      });
    }

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

    final JwtPayloadModel model;

    if (payloadData.containsKey('email')) {
      model = JwtPayloadAuthorizedModel.fromJson(payloadData);
    } else {
      model = JwtPayloadGuestModel.fromJson(payloadData);
    }

    return model;
  }
}
