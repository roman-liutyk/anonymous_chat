class MessageModel {
  const MessageModel({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.createdAt,
    required this.content,
    required this.senderUsername,
  });

  final String id;
  final String chatId;
  final String senderId;
  final int createdAt;
  final String content;
  final String senderUsername;

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as String,
      chatId: json['chatId'] as String,
      senderId: json['senderId'] as String,
      createdAt: json['createdAt'] as int,
      content: json['content'] as String,
      senderUsername: json['senderUsername'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chatId': chatId,
      'senderId': senderId,
      'createdAt': createdAt.toString(),
      'content': content,
      'senderUsername': senderUsername,
    };
  }
}
