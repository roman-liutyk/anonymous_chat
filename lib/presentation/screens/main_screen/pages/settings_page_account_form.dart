import 'package:anonymous_chat/domain/entities/user.dart';
import 'package:anonymous_chat/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:anonymous_chat/presentation/blocs/user_bloc/user_event.dart';
import 'package:anonymous_chat/presentation/widgets/custom_button.dart';
import 'package:anonymous_chat/presentation/widgets/custom_text_form_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPageAccountForm extends StatefulWidget {
  const SettingsPageAccountForm({super.key});

  @override
  State<SettingsPageAccountForm> createState() =>
      _SettingsPageAccountFormState();
}

class _SettingsPageAccountFormState extends State<SettingsPageAccountForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameTextFormController = TextEditingController();
  final _emailTextFormController = TextEditingController();

  @override
  void initState() {
    final User? user = BlocProvider.of<UserBloc>(context).state.user;

    if (user != null) {
      _usernameTextFormController.text = user.username;
      _emailTextFormController.text = user.email;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextFormField(
            controller: _usernameTextFormController,
            hintText: 'Username',
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a valid username';
              }

              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
            controller: _emailTextFormController,
            hintText: 'Email',
            validator: (value) {
              if (value == null || value.trim().isEmpty || !EmailValidator.validate(value)) {
                return 'Please enter a valid email';
              }

              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: 'Save',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                BlocProvider.of<UserBloc>(context).add(UserEventUpdateData(
                  username: _usernameTextFormController.text,
                  email: _emailTextFormController.text,
                ));
              }
            },
          ),
        ],
      ),
    );
  }
}
