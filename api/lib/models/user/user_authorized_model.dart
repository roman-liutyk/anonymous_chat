import 'package:api/models/user/user_model.dart';

/// Abstract model of the authorized user.
///
/// Extends [UserModel].
abstract class UserAuthorizedModel extends UserModel {
  const UserAuthorizedModel({
    required String id,
    required String username,
    required AuthMethod authMethod,
    required this.email,
  }) : super(
          id: id,
          username: username,
          authMethod: authMethod,
        );

  /// `email` - field for the user email [String].
  final String email;
}
