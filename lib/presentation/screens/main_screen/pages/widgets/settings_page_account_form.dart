import 'package:anonymous_chat/domain/entities/user/user.dart';
import 'package:anonymous_chat/domain/entities/user/user_basic.dart';
import 'package:anonymous_chat/domain/entities/user/user_google.dart';
import 'package:anonymous_chat/domain/entities/user/user_guest.dart';
import 'package:anonymous_chat/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:anonymous_chat/presentation/blocs/user_bloc/user_event.dart';
import 'package:anonymous_chat/presentation/blocs/user_bloc/user_state.dart';
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

  bool canEditAccountData = false;
  bool displayEmail = false;
  bool displaySaveButton = true;

  @override
  void initState() {
    final User? user = BlocProvider.of<UserBloc>(context).state.user;

    if (user is UserBasic) {
      _usernameTextFormController.text = user.username;
      _emailTextFormController.text = user.email;

      canEditAccountData = true;
      displayEmail = true;
      displaySaveButton = true;
    } else if (user is UserGoogle) {
      _usernameTextFormController.text = user.username;

      canEditAccountData = true;
      displayEmail = false;
      displaySaveButton = true;
      displayEmail = false;
    } else if (user is UserGuest) {
      _usernameTextFormController.text = user.username;

      canEditAccountData = false;
      displayEmail = false;
      displaySaveButton = false;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        // final bool displaySaveButton = userState.user!.authMethod != AuthMethod.guest;

        return Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextFormField(
                controller: _usernameTextFormController,
                hintText: 'Username',
                readOnly: !canEditAccountData,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a valid username';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 20),
              !displayEmail
                  ? const SizedBox.shrink()
                  : CustomTextFormField(
                      controller: _emailTextFormController,
                      hintText: 'Email',
                      readOnly: !canEditAccountData,
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            !EmailValidator.validate(value)) {
                          return 'Please enter a valid email';
                        }

                        return null;
                      },
                    ),
              !displayEmail
                  ? const SizedBox.shrink()
                  : const SizedBox(height: 20),
              !displaySaveButton
                  ? const SizedBox.shrink()
                  : CustomButton(
                      text: 'Save',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final String username =
                              _usernameTextFormController.text;
                          final String email = _emailTextFormController.text;

                          BlocProvider.of<UserBloc>(context)
                              .add(UserEventUpdateData(
                            username: username,
                            email: email.trim().isEmpty ? null : email,
                          ));

                          FocusScope.of(context).requestFocus(FocusNode());
                        }
                      },
                    ),
            ],
          ),
        );
      },
    );
  }
}
