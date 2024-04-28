import 'dart:convert';

import 'package:api/models/message_model.dart';
import 'package:firedart/firedart.dart';

/// Contains methods related to handling chat messages in [Firestore].
///
/// Recieves [Firestore] instance inside of the constructor parameters.
class ChatService {
  const ChatService(this._firestore);

  final Firestore _firestore;

  /// Recives encoded `message` JSON as [String] in the method parameters.
  ///
  /// Decodes recieved `message` and uses [MessageModel.fromJson] to convert
  /// JSON to [MessageModel].
  ///
  /// As a result writes [MessageModel] to our [Firestore] database and returns
  /// [MessageModel];
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
