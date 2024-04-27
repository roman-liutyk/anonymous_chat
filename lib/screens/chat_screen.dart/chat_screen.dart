import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.blue,
            size: 25,
          ),
        ),
        title: const Text('Another Username'),
        centerTitle: true,
      ),
      // body: ListView.separated(
      //   itemBuilder: itemBuilder,
      //   separatorBuilder: separatorBuilder,
      //   itemCount: itemCount,
      // ),
      body: Column(
        children: [
          Expanded(
            child: Container(),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            color: Colors.blue.withOpacity(0.1),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageTextController,
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
                        borderRadius: BorderRadius.circular(50),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                // IconButton(
                //   onPressed: () {
                //     //
                //   },
                //   // icon: Container(
                //   //   color: Colors.red,
                //   //   width: 30,
                //   //   height: 30,
                //   // ),
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
