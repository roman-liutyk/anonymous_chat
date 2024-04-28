import 'package:anonymous_chat/domain/entities/user/user.dart';

class UserGoogle extends User {
  const UserGoogle({
    required super.id,
    required super.username,
    required this.email,
    super.authMethod = AuthMethod.google,
  });

  final String email;
}
