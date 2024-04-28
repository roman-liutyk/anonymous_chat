import 'package:api/models/user/user_authorized_model.dart';
import 'package:api/models/user/user_model.dart';

/// Contains fields that are needed for managing the user that signed in using
/// `Google`.
///
/// Extends [UserModel] and assigns [AuthMethod.google] to [authMethod].
class UserGoogleModel extends UserAuthorizedModel {
  const UserGoogleModel({
    required String id,
    required String username,
    required String email,
    AuthMethod authMethod = AuthMethod.google,
  }) : super(
          id: id,
          username: username,
          email: email,
          authMethod: authMethod,
        );

  /// Factory constructor that recieves JSON in the parameters and creates the
  /// instance of [UserGoogleModel].
  ///
  /// Creating the instance is done by assigning the certain value from JSON to
  /// certain field parameter in [UserGoogleModel].
  factory UserGoogleModel.fromJson(Map<String, dynamic> json) {
    return UserGoogleModel(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      authMethod: AuthMethod.values.firstWhere(
        (method) => method.name == json['authMethod'],
      ),
    );
  }

  /// Method that converts [UserGoogleModel] to JSON.
  ///
  /// It creates [Map] with the names of the model fields as `keys` and field
  /// values as `values` assign to the `keys`.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'authMethod': authMethod.name,
    };
  }

  /// Calls factory [fromJson] constructor.
  UserModel fromJson(Map<String, dynamic> json) {
    return UserGoogleModel.fromJson(json);
  }
}
