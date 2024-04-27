import 'package:anonymous_chat/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:anonymous_chat/presentation/blocs/auth_bloc/auth_event.dart';
import 'package:anonymous_chat/presentation/widgets/custom_button.dart';
import 'package:anonymous_chat/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
    this.switchForm,
  });

  final void Function()? switchForm;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailTextFormController = TextEditingController();
  final _passwordTextFormController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Registration',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextButton(
                onPressed: widget.switchForm,
                child: const Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
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
          CustomTextFormField(
            controller: _passwordTextFormController,
            obscureText: true,
            hintText: 'Password',
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter valid password';
              }

              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: 'Sign up',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                BlocProvider.of<AuthBloc>(context).add(AuthEventSignUp(
                  email: _emailTextFormController.text,
                  password: _passwordTextFormController.text,
                ));
              }
            },
          ),
        ],
      ),
    );
  }
}
