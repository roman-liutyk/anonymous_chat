import 'package:anonymous_chat/data/models/message_model.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageTextController = TextEditingController();

  final _messages = <MessageModel>[
    MessageModel(
      id: '1',
      chatId: '1',
      senderId: '1',
      createdAt: DateTime.now(),
      content: 'sdfsdf',
      senderUsername: 'sdfds',
    ),
    MessageModel(
      id: '2',
      chatId: '1',
      senderId: '1',
      createdAt: DateTime.now(),
      content: 'sdfssdfsdddddddddddfsdfdf',
      senderUsername: 'sdfds',
    ),
    MessageModel(
      id: '3',
      chatId: '1',
      senderId: '2',
      createdAt: DateTime.now(),
      content: 'sdffsdfdsfsfsdf',
      senderUsername: 'sdfds',
    ),
    MessageModel(
      id: '5',
      chatId: '1',
      senderId: '2',
      createdAt: DateTime.now(),
      content: 'sdffsdfdsfsfsdffffffffffffffffffffsdf',
      senderUsername: 'sdfds',
    ),
    MessageModel(
      id: '6',
      chatId: '1',
      senderId: '1',
      createdAt: DateTime.now(),
      content: 'sdffsdfdsfsfsdf',
      senderUsername: 'sdfds',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
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
                final message = _messages[index];

                return Align(
                  alignment: message.senderId == '1'
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    constraints: BoxConstraints(
                      minWidth: 10,
                      maxWidth: MediaQuery.of(context).size.width * 0.6,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: message.senderId == '1'
                          ? Colors.blue.withOpacity(0.8)
                          : Colors.blue.withRed(110).withGreen(60),
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(7),
                        topRight: const Radius.circular(7),
                        bottomLeft:
                            Radius.circular(message.senderId == '1' ? 7 : 0),
                        bottomRight:
                            Radius.circular(message.senderId == '1' ? 0 : 7),
                      ),
                    ),
                    child: Text(message.content),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemCount: _messages.length,
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
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // TODO send message
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
  }
}
