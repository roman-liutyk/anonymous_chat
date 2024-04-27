import 'package:anonymous_chat/screens/main_screen/pages/settings_page_account_form.dart';
import 'package:anonymous_chat/widgets/custom_button.dart';
import 'package:flutter/material.dart';

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
                /// TODO delete account
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
