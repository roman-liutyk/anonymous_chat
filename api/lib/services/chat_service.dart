import 'dart:convert';

import 'package:api/models/message_model.dart';
import 'package:firedart/firedart.dart';

class ChatService {
  const ChatService(this._firestore);

  final Firestore _firestore;

  Future<MessageModel> addMessage(String message) async {
    final model = MessageModel.fromJson(jsonDecode(message));
    await _firestore
        .collection('chats')
        .document('1')
        .collection('messages')
        .document(model.id)
        .set(
          model.toJson(),
        );

    return model;
  }
}
