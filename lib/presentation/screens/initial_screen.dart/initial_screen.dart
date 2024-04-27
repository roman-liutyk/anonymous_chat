import 'package:anonymous_chat/presentation/screens/auth_screen/auth_screen.dart';
import 'package:anonymous_chat/presentation/screens/main_screen/main_screen.dart';
import 'package:flutter/material.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  final bool userIsSignedIn = false;

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      if (userIsSignedIn) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AuthScreen()),
        );
      }
    });
    
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
