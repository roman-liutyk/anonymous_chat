import 'package:anonymous_chat/screens/auth_screen/sign_in_form.dart';
import 'package:anonymous_chat/screens/auth_screen/sign_up_form.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _displaySignInForm = true;

  void switchForm() {
    setState(() {
      _displaySignInForm = !_displaySignInForm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: _displaySignInForm
              ? SignInForm(switchForm: switchForm)
              : SignUpForm(switchForm: switchForm),
        ),
      ),
    );
  }
}
