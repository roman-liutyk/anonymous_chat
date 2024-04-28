/// Contains fields that are neaded for storing the message and
/// [MessageModel.fromJson] and [toJson] for hadling from to JSON converting.
class MessageModel {
  const MessageModel({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.createdAt,
    required this.content,
    required this.senderUsername,
  });

  /// `id` - identifier of the message in the database.
  final String id;

  /// `chatId` - identifier of the chat that is message is stored in inside the
  /// database.
  final String chatId;

  /// `senderId` - identifier of user that sent a message.
  final String senderId;

  /// `senderUsername` - username of user that sent a message.
  final String senderUsername;

  /// `senderUsername` - date and time when the message was created store as
  /// timestamp.
  final int createdAt;

  /// `content` - the message that user sent.
  final String content;

  /// Factory constructor that recieves JSON in the parameters and creates the
  /// instance of [MessageModel].
  ///
  /// Creating the instance is done by assigning the certain value from JSON to
  /// certain field parameter in [MessageModel].
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

  /// Method that converts [MessageModel] to JSON.
  ///
  /// It creates [Map] with the names of the model fields as `keys` and field
  /// values as `values` assign to the `keys`.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chatId': chatId,
      'senderId': senderId,
      'createdAt': createdAt,
      'content': content,
      'senderUsername': senderUsername,
    };
  }
}
