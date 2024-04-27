class MessageModel {
  const MessageModel({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.createdAt,
    required this.content,
  });

  final String id;
  final String chatId;
  final String senderId;
  final DateTime createdAt;
  final String content;

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as String,
      chatId: json['chatId'] as String,
      senderId: json['senderId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      content: json['content'] as String,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chatId': chatId,
      'senderId': senderId,
      'createdAt': createdAt.toString(),
      'content': content,
    };
  }
}