import 'package:anonymous_chat/data/models/message_model.dart';
import 'package:anonymous_chat/presentation/blocs/chat_bloc/chat_bloc.dart';
import 'package:anonymous_chat/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:anonymous_chat/presentation/blocs/user_bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/v4.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserStateInitialized || state is UserStateUpdated) {
          final user = state.user;
          return BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              if (state is ChatLoading) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is ChatLoaded) {
                return Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        context.read<ChatBloc>().add(const DisconnectEvent());
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.blue,
                        size: 30,
                      ),
                    ),
                    title: const Text('Another Username'),
                    centerTitle: true,
                  ),
                  body: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.all(15),
                          itemBuilder: (context, index) {
                            final message = state.messages[index];

                            return Align(
                              alignment: message.senderId == user?.id
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                constraints: BoxConstraints(
                                  minWidth: 10,
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.6,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: message.senderId == user?.id
                                      ? Colors.blue.withOpacity(0.8)
                                      : Colors.blue.withRed(110).withGreen(60),
                                  borderRadius: BorderRadius.only(
                                    topLeft: const Radius.circular(7),
                                    topRight: const Radius.circular(7),
                                    bottomLeft: Radius.circular(
                                        message.senderId == user?.id ? 7 : 0),
                                    bottomRight: Radius.circular(
                                        message.senderId == user?.id ? 0 : 7),
                                  ),
                                ),
                                child: Text(message.content),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 15),
                          itemCount: state.messages.length,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 15,
                        ),
                        color: Colors.blue.withOpacity(0.15),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _messageTextController,
                                maxLines: 6,
                                minLines: 1,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Message',
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey[300],
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 20,
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                context.read<ChatBloc>().add(
                                      AddMessageEvent(
                                        MessageModel(
                                          id: const UuidV4().generate(),
                                          chatId: '1',
                                          senderId: user?.id ?? '',
                                          senderUsername: user?.username ?? '',
                                          createdAt: DateTime.now(),
                                          content: _messageTextController.text
                                              .trim(),
                                        ),
                                      ),
                                    );
                                _messageTextController.clear();
                              },
                              icon: Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: const Icon(
                                  Icons.send,
                                  size: 22,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
