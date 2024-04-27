
import 'package:anonymous_chat/presentation/widgets/custom_button.dart';
import 'package:anonymous_chat/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class SettingsPageAccountForm extends StatefulWidget {
  const SettingsPageAccountForm({super.key});

  @override
  State<SettingsPageAccountForm> createState() =>
      _SettingsPageAccountFormState();
}

class _SettingsPageAccountFormState extends State<SettingsPageAccountForm> {
  final _formKey = GlobalKey<FormState>();
  final _userNameTextFormController = TextEditingController(text: 'Username');
  final _emailTextFormController =
      TextEditingController(text: 'email@example.com');

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextFormField(
            controller: _userNameTextFormController,
            hintText: 'Username',
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter valid username';
              }

              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
            controller: _emailTextFormController,
            hintText: 'Email',
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter valid email';
              }

              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: 'Save',
            onPressed: () {
              // TODO update data
              if (_formKey.currentState!.validate()) {
                ///
              }
            },
          ),
        ],
      ),
    );
  }
}
