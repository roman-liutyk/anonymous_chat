import 'package:anonymous_chat/domain/entities/user/user.dart';

class UserBasic extends User {
  const UserBasic({
    required super.id,
    required super.username,
    required this.email,
    required this.password,
    super.authMethod = AuthMethod.passwordAndEmail,
  });

  final String email;
  final String password;
}
