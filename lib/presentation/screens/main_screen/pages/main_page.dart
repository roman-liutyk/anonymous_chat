import 'package:anonymous_chat/presentation/screens/chat_screen.dart/chat_screen.dart';
import 'package:anonymous_chat/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: CustomButton(
          onPressed: () {
            // TODO search room
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ChatScreen()),
            );
          },
          text: 'Start chatting',
        ),
      ),
    );
  }
}
