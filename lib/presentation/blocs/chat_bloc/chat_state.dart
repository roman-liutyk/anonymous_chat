part of 'chat_bloc.dart';

abstract class ChatState {
  const ChatState();
}

final class ChatInitial extends ChatState {
  const ChatInitial();
}

final class ChatLoading extends ChatState {
  const ChatLoading();
}

final class ChatLoaded extends ChatState {
  const ChatLoaded(
    this.messages,
  );

  final List<MessageModel> messages;
}

final class ChatError extends ChatState {
  const ChatError();
}
