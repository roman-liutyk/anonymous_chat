class Message {
  const Message({
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
}