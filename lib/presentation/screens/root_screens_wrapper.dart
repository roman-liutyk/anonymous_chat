import 'package:anonymous_chat/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:anonymous_chat/presentation/blocs/auth_bloc/auth_state.dart';
import 'package:anonymous_chat/presentation/screens/auth_screen/auth_screen.dart';
import 'package:anonymous_chat/presentation/screens/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootScreensWrapper extends StatelessWidget {
  const RootScreensWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        if (authState is AuthStateAuthorized) {
          return const MainScreen();
        }

        return const AuthScreen();
      },
    );
  }
}
