import 'dart:async';
import 'dart:convert';

import 'package:anonymous_chat/core/app_constants.dart';
import 'package:anonymous_chat/core/services/secure_storage_service.dart';
import 'package:anonymous_chat/data/models/message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/io.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(
    this._storage,
  ) : super(const ChatInitial()) {
    on<InitEvent>(_init);
    on<AddMessageEvent>(_addMessage);
    on<UpdateListEvent>(_updateList);
    on<DisconnectEvent>(_disconnect);
  }

  final SecureSotrageService _storage;
  final List<MessageModel> _messages = [];
  DateTime? _initTime;

  IOWebSocketChannel? _channel;

  Future<void> _init(
    InitEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(const ChatLoading());
    _initTime = DateTime.now();

    final token = await _storage.getUserToken();

    final uri = Uri.parse('ws://${AppConstants.host}/chat/ws');
    final channel = IOWebSocketChannel.connect(
      uri,
      headers: {
        'Authorization': token,
      },
    );

    await channel.ready;

    _channel = channel;

    emit(const ChatLoaded([]));

    _channel?.stream.listen(
      (event) {
        final model = MessageModel.fromJson(jsonDecode(event));

        _initTime ??= DateTime.now();

        if (model.createdAt.isAfter(_initTime!)) {
          _messages.add(model);

          add(const UpdateListEvent());
        }
      },
    );
  }

  Future<void> _addMessage(
    AddMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    _channel?.sink.add(
      jsonEncode(
        event.model.toJson(),
      ),
    );
  }

  Future<void> _updateList(
    UpdateListEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoaded(_messages));
  }

  Future<void> _disconnect(
    DisconnectEvent event,
    Emitter<ChatState> emit,
  ) async {
    _channel?.sink.close();
    _messages.clear();
    _initTime = null;
  }

  @override
  Future<void> close() async {
    await _channel?.sink.close();
    _messages.clear();
    _initTime = null;
    return super.close();
  }
}
