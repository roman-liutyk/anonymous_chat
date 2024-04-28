import 'package:anonymous_chat/domain/entities/user/user.dart';

class UserGuest extends User {
  const UserGuest({
    required super.id,
    required super.username,
    super.authMethod = AuthMethod.guest,
  });
}
