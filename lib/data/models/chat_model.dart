import 'package:anonymous_chat/data/models/message_model.dart';
import 'package:anonymous_chat/data/models/user_model.dart';

class ChatModel {
  const ChatModel({
    required this.id,
    required this.users,
    required this.messages,
  });

  final String id;
  final List<UserModel> users;
  final List<MessageModel> messages;

}