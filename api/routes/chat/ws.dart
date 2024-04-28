import 'dart:convert';

import 'package:api/services/chat_service.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';
import 'package:firedart/firedart.dart';

/// WebSocket endpoint that can be accessed by `ws://{{host}}/chat/ws`.
///
/// Responsible for recieving [String] event from the user and writing it to the
/// [Firestore] using [ChatService.addMessage].
///
/// It returns that written message from [Firestore] by listeting to the
/// [Firestore] changes in `chats/1/messages` collection.
Future<Response> onRequest(RequestContext context) async {
  final handler = webSocketHandler((channel, protocol) {
    Firestore.instance
        .collection('chats')
        .document('1')
        .collection('messages')
        .stream
        .listen((event) {
      channel.sink.add(jsonEncode(event.last.map));
    });

    channel.stream.listen(
      (message) async {
        await context.read<ChatService>().addMessage(message);
      },
      onDone: () {},
    );
  });

  return handler(context);
}
