import 'package:anonymous_chat/core/di/locator.dart';
import 'package:anonymous_chat/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:anonymous_chat/presentation/blocs/auth_bloc/auth_event.dart';
import 'package:anonymous_chat/presentation/screens/root_screens_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            authRepository: getIt.get(),
            userRepository: getIt.get(),
          )..add(const AuthEventInitialize()),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: RootScreensWrapper(),
      ),
    );
  }
}
