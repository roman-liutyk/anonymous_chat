import 'package:anonymous_chat/data/repositories/api_auth_repository.dart';
import 'package:anonymous_chat/presentation/screens/main_screen/main_screen.dart';
import 'package:anonymous_chat/presentation/widgets/custom_button.dart';
import 'package:anonymous_chat/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key,
    this.switchForm,
  });

  final void Function()? switchForm;

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
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
                'Sign In',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextButton(
                onPressed: widget.switchForm,
                child: const Text(
                  'Registration',
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
            text: 'Sign in',
            onPressed: () {
              // TODO sign in
              // if (_formKey.currentState!.validate()) {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const MainScreen()),
                );
                // AuthRepository(client: Client()).signIn(email: 'example@gmail.com', password: '12345678');
                // AuthRepository(client: Client()).signUp(email: 'test@gmail.com', password: '12345678');
              // }
            },
          ),
        ],
      ),
    );
  }
}