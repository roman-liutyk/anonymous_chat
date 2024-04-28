import 'package:anonymous_chat/domain/entities/message.dart';

class MessageModel {
  const MessageModel({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.senderUsername,
    required this.createdAt,
    required this.content,
  });

  final String id;
  final String chatId;
  final String senderId;
  final String senderUsername;
  final DateTime createdAt;
  final String content;

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as String,
      chatId: json['chatId'] as String,
      senderId: json['senderId'] as String,
      senderUsername: json['senderUsername'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt'] as int),
      content: json['content'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chatId': chatId,
      'senderId': senderId,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'content': content,
      'senderUsername': senderUsername,
    };
  }

  Message toMessage() {
    return Message(
      id: id,
      chatId: chatId,
      senderId: senderId,
      senderUsername: senderUsername,
      createdAt: createdAt,
      content: content,
    );
  }

  factory MessageModel.fromMessage(Message message) {
    return MessageModel(
      id: message.id,
      chatId: message.chatId,
      senderId: message.senderId,
      senderUsername: message.senderUsername,
      createdAt: message.createdAt,
      content: message.content,
    );
  }
}
