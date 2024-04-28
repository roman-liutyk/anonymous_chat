import 'package:api/services/chat_service.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';
import 'package:firedart/firedart.dart';

Future<Response> onRequest(RequestContext context) async {
  final handler = webSocketHandler((channel, protocol) {
    Firestore.instance
        .collection('chats')
        .document('1')
        .collection('messages')
        .stream
        .listen((event) {
      channel.sink.add(event.last.map);
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
