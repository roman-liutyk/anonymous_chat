import 'package:anonymous_chat/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:anonymous_chat/presentation/blocs/auth_bloc/auth_event.dart';
import 'package:anonymous_chat/presentation/screens/auth_screen/widgets/auth_form_separator.dart';
import 'package:anonymous_chat/presentation/widgets/custom_button.dart';
import 'package:anonymous_chat/presentation/widgets/custom_oulined_button.dart';
import 'package:anonymous_chat/presentation/widgets/custom_text_form_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    super.key,
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
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Form(
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
                if (value == null ||
                    value.trim().isEmpty ||
                    !EmailValidator.validate(value)) {
                  return 'Please enter a valid email';
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
                  return 'Please enter a valid password';
                }

                return null;
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Sign in',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  BlocProvider.of<AuthBloc>(context).add(AuthEventSignIn(
                    email: _emailTextFormController.text,
                    password: _passwordTextFormController.text,
                  ));
                }
              },
            ),
            const SizedBox(height: 40),
            const AuthFormSeparator(),
            const SizedBox(height: 40),
            CustomOutlinedButton(
              text: 'Sign in as Guest',
              borderColor: Colors.grey[600]!,
              foregroundColor: Colors.grey[700]!,
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(
                  const AuthEventSignUpAsGuest(),
                );
              },
            ),
            const SizedBox(height: 20),
            CustomOutlinedButton(
              text: 'Sign in with Google',
              borderColor: Colors.black,
              foregroundColor: Colors.black,
              icon: SvgPicture.asset(
                'assets/google.svg',
                width: 25,
                height: 25,
              ),
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(
                  const AuthEventSignInWithGoogle(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
