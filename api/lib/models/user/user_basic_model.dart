import 'package:api/models/user/user_authorized_model.dart';
import 'package:api/models/user/user_model.dart';

/// Model for the regular user that extends [UserAuthorizedModel] and assigns
/// [AuthMethod.passwordAndEmail] to the [authMethod].
class UserBasicModel extends UserAuthorizedModel {
  const UserBasicModel({
    required String id,
    required String username,
    required String email,
    required this.password,
    AuthMethod authMethod = AuthMethod.passwordAndEmail,
  }) : super(
          id: id,
          username: username,
          email: email,
          authMethod: authMethod,
        );

  /// 'password' - encrypted user password.
  final String password;

  /// Factory constructor that recieves JSON in the parameters and creates the
  /// instance of [UserBasicModel].
  ///
  /// Creating the instance is done by assigning the certain value from JSON to
  /// certain field parameter in [UserBasicModel].
  factory UserBasicModel.fromJson(Map<String, dynamic> json) {
    return UserBasicModel(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      authMethod: AuthMethod.values.firstWhere(
        (method) => method.name == json['authMethod'],
      ),
    );
  }

  /// Method that converts [UserBasicModel] to JSON.
  ///
  /// It creates [Map] with the names of the model fields as `keys` and field
  /// values as `values` assign to the `keys`.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'authMethod': authMethod.name,
    };
  }

  /// Calls factory [fromJson] constructor.
  UserModel fromJson(Map<String, dynamic> json) {
    return UserBasicModel.fromJson(json);
  }
}
