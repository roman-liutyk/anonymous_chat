import 'package:anonymous_chat/domain/entities/message.dart';
import 'package:anonymous_chat/domain/entities/user.dart';

class Chat {
  const Chat({
    required this.id,
    required this.users,
    required this.messages,
  });

  final String id;
  final List<User> users;
  final List<Message> messages;
}
