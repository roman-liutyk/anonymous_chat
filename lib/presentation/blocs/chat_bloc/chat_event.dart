part of 'chat_bloc.dart';

abstract class ChatEvent {
  const ChatEvent();
}

class InitEvent extends ChatEvent {
  const InitEvent();
}

class UpdateListEvent extends ChatEvent {
  const UpdateListEvent();
}

class AddMessageEvent extends ChatEvent {
  const AddMessageEvent(this.model);

  final MessageModel model;
}

class DisconnectEvent extends ChatEvent {
  const DisconnectEvent();
}
