import 'package:anonymous_chat/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:anonymous_chat/presentation/blocs/auth_bloc/auth_state.dart';
import 'package:anonymous_chat/presentation/screens/auth_screen/sign_in_form.dart';
import 'package:anonymous_chat/presentation/screens/auth_screen/sign_up_form.dart';
import 'package:anonymous_chat/presentation/widgets/custom_error_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, authState) {
          if (authState is AuthStateAuthorized && authState.exception != null) {
            showCustomScnackbar(
              context: context,
              text: authState.exception!.text,
              title: authState.exception!.title,
              isError: true,
            );
          } else if (authState is AuthStateUnauthorized &&
              authState.exception != null) {
            showCustomScnackbar(
              context: context,
              text: authState.exception!.text,
              title: authState.exception!.title,
              isError: true,
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: _displaySignInForm
                ? SignInForm(switchForm: switchForm)
                : SignUpForm(switchForm: switchForm),
          ),
        ),
      ),
    );
  }
}
