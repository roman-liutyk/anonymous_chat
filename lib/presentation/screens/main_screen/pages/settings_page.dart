import 'package:anonymous_chat/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:anonymous_chat/presentation/blocs/auth_bloc/auth_event.dart';
import 'package:anonymous_chat/presentation/screens/main_screen/pages/settings_page_account_form.dart';
import 'package:anonymous_chat/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            const Text(
              'Account data',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 30),
            const SettingsPageAccountForm(),
            const Spacer(),
            CustomButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(
                  const AuthEventSignOut(),
                );
              },
              text: 'Sign Out',
              backgroundColor: Colors.blue,
            ),
            const SizedBox(height: 20),
            CustomButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(
                  const AuthEventDeleteAccount(),
                );
              },
              text: 'Delete account',
              backgroundColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
