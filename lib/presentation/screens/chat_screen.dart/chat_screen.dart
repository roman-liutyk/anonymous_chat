import 'package:anonymous_chat/data/models/message_model.dart';
import 'package:anonymous_chat/presentation/blocs/chat_bloc/chat_bloc.dart';
import 'package:anonymous_chat/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:anonymous_chat/presentation/blocs/user_bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/v4.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageTextController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _messageFocusNode = FocusNode();

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
                  body: DecoratedBox(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromRGBO(238, 238, 238, 1),
                          Color.fromRGBO(245, 245, 245, 1),
                          Color.fromRGBO(238, 238, 238, 1),
                        ],
                      ),
                    ),
                    child: SafeArea(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  context
                                      .read<ChatBloc>()
                                      .add(const DisconnectEvent());
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  color: Colors.grey[500],
                                  size: 24,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'anonumous-group-chat',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: ListView.separated(
                              physics: const ClampingScrollPhysics(),
                              controller: _scrollController,
                              padding: const EdgeInsets.all(15),
                              itemBuilder: (context, index) {
                                if (index == state.messages.length) {
                                  return const SizedBox(
                                    height: 10,
                                  );
                                } else {
                                  final message = state.messages[index];

                                  return Column(
                                    crossAxisAlignment:
                                        message.senderId == user?.id
                                            ? CrossAxisAlignment.end
                                            : CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: index > 0 &&
                                                state.messages[index - 1]
                                                        .senderId !=
                                                    state.messages[index]
                                                        .senderId
                                            ? 15
                                            : 0,
                                      ),
                                      index > 0 &&
                                              state.messages[index - 1]
                                                      .senderId !=
                                                  state.messages[index].senderId
                                          ? Divider(
                                              height: 2,
                                              thickness: 2,
                                              color: Colors.grey[200],
                                            )
                                          : const SizedBox.shrink(),
                                      SizedBox(
                                        height: index > 0 &&
                                                state.messages[index - 1]
                                                        .senderId !=
                                                    state.messages[index]
                                                        .senderId
                                            ? 15
                                            : 0,
                                      ),
                                      index == 0 ||
                                              state.messages[index - 1]
                                                      .senderId !=
                                                  state.messages[index].senderId
                                          ? Text(
                                              '@${message.senderUsername}',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )
                                          : const SizedBox.shrink(),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          message.senderId == user?.id
                                              ? Text(
                                                  DateFormat('HH:mm').format(
                                                      message.createdAt),
                                                  style: TextStyle(
                                                    color: Colors.grey[500],
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          Expanded(
                                            child: Text(
                                              message.content,
                                              textAlign:
                                                  message.senderId == user?.id
                                                      ? TextAlign.right
                                                      : TextAlign.left,
                                              style: TextStyle(
                                                color: Colors.grey[800],
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          message.senderId != user?.id
                                              ? Text(
                                                  DateFormat('HH:mm').format(
                                                      message.createdAt),
                                                  style: TextStyle(
                                                    color: Colors.grey[500],
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                        ],
                                      ),
                                    ],
                                  );
                                }
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 5),
                              itemCount: state.messages.length + 1,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 15,
                            ),
                            color: Colors.white,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    focusNode: _messageFocusNode,
                                    controller: _messageTextController,
                                    maxLines: 6,
                                    minLines: 1,
                                    onTapOutside: (event) {
                                      _messageFocusNode.unfocus();
                                    },
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[800],
                                    ),
                                    decoration: InputDecoration(
                                      fillColor: Colors.grey[300],
                                      filled: true,
                                      hintText: 'Message',
                                      hintStyle: TextStyle(
                                        color: Colors.grey[800],
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 12,
                                        horizontal: 20,
                                      ),
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (_messageTextController.text
                                        .trim()
                                        .isNotEmpty) {
                                      _messageFocusNode.unfocus();
                                      context.read<ChatBloc>().add(
                                            AddMessageEvent(
                                              MessageModel(
                                                id: const UuidV4().generate(),
                                                chatId: '1',
                                                senderId: user?.id ?? '',
                                                senderUsername:
                                                    user?.username ?? '',
                                                createdAt: DateTime.now(),
                                                content: _messageTextController
                                                    .text
                                                    .trim(),
                                              ),
                                            ),
                                          );
                                      _messageTextController.clear();

                                      Future.delayed(
                                        const Duration(
                                          milliseconds: 200,
                                        ),
                                      ).then(
                                        (value) => _scrollController.jumpTo(
                                            _scrollController
                                                .position.maxScrollExtent),
                                      );
                                    }
                                  },
                                  icon: Container(
                                    width: 45,
                                    height: 45,
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 0, 89, 204),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.send_rounded,
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
                    ),
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
