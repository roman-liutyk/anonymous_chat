import 'dart:io';

import 'package:api/models/jwt_payload/jwt_payload_authorized_model.dart';
import 'package:api/models/jwt_payload/jwt_payload_guest_model.dart';
import 'package:api/models/jwt_payload/jwt_payload_model.dart';
import 'package:api/models/user/user_authorized_model.dart';
import 'package:api/models/user/user_model.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

/// Contains methods for `signing` and `verifying` JWT token.
class JwtHelper {
  /// Recieves [UserModel] as a method parameter and creates [JWT] instances
  /// with `user` info in payload.
  ///
  /// Then, signs the token using [JWT.sign] method and passes the [SecretKey]
  /// with the `SECRET_KEY` that is stored inside the env file.
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
        Platform.environment['SECRET_KEY'] ?? '',
      ),
    );

    return token;
  }

  /// Recieves JWT token in method parameter and uses [JWT.verify] for token
  /// verfication.
  ///
  /// It return decrypted JSON payload, that we write as a
  /// [JwtPayloadAuthorizedModel] or [JwtPayloadGuestModel] depending on `email`
  /// presence.
  ///
  /// As a result, returns [JwtPayloadAuthorizedModel] or [JwtPayloadGuestModel]
  /// model.
  static JwtPayloadModel verifyJWT(String token) {
    final payload = JWT.verify(
      token,
      SecretKey(
        Platform.environment['SECRET_KEY'] ?? '',
      ),
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
