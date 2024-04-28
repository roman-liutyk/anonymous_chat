import 'package:api/models/user/user_model.dart';

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

  final String email;
}
