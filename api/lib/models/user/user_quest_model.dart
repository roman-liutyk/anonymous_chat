import 'package:api/models/user/user_model.dart';

/// Contains fields that are needed for managing guest user.
///
/// Extends [UserModel] and assigns [AuthMethod.guest] to [authMethod].
class UserGuestModel extends UserModel {
  const UserGuestModel({
    required String id,
    required String username,
    AuthMethod authMethod = AuthMethod.guest,
  }) : super(
          id: id,
          username: username,
          authMethod: authMethod,
        );

  /// Factory constructor that recieves JSON in the parameters and creates the
  /// instance of [UserGuestModel].
  ///
  /// Creating the instance is done by assigning the certain value from JSON to
  /// certain field parameter in [UserGuestModel].
  factory UserGuestModel.fromJson(Map<String, dynamic> json) {
    return UserGuestModel(
      id: json['id'] as String,
      username: json['username'] as String,
      authMethod: AuthMethod.values.firstWhere(
        (method) => method.name == json['authMethod'],
      ),
    );
  }

  /// Method that converts [UserGuestModel] to JSON.
  ///
  /// It creates [Map] with the names of the model fields as `keys` and field
  /// values as `values` assign to the `keys`.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'authMethod': authMethod.name,
    };
  }

  /// Calls factory [fromJson] constructor.
  UserModel fromJson(Map<String, dynamic> json) {
    return UserGuestModel.fromJson(json);
  }
}
