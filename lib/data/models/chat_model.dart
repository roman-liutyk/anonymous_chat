import 'package:anonymous_chat/data/models/message_model.dart';
import 'package:anonymous_chat/data/models/user/user_model.dart';
import 'package:anonymous_chat/domain/entities/chat.dart';

class ChatModel {
  const ChatModel({
    required this.id,
    required this.users,
    required this.messages,
  });

  final String id;
  final List<UserModel> users;
  final List<MessageModel> messages;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'users': users.map((user) => user.toJson()).toList(),
      'messages': messages.map((message) => message.toJson()).toList(),
    };
  }

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'] as String,
      users: (json['users'] as List)
          .map((user) => UserModel.fromJson(user as Map<String, dynamic>))
          .toList(),
      messages: (json['messages'] as List)
          .map((message) =>
              MessageModel.fromJson(message as Map<String, dynamic>))
          .toList(),
    );
  }

  Chat toChat() {
    return Chat(
      id: id,
      users: users.map((user) => user.toUser()).toList(),
      messages: messages.map((message) => message.toMessage()).toList(),
    );
  }

  factory ChatModel.fromChat(Chat chat) {
    return ChatModel(
      id: chat.id,
      users: chat.users.map((user) => UserModel.fromUser(user)).toList(),
      messages: chat.messages
          .map((message) => MessageModel.fromMessage(message))
          .toList(),
    );
  }
}
