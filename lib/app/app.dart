import 'package:anonymous_chat/screens/chat_screen.dart/chat_screen.dart';
import 'package:anonymous_chat/screens/initial_screen.dart/initial_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: ChatScreen(),
      home: InitialScreen(),
    );
  }
}
