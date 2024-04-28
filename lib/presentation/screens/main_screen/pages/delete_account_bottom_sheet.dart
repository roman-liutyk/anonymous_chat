import 'package:anonymous_chat/core/erorrs/auth_exception.dart';
import 'package:anonymous_chat/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:anonymous_chat/presentation/blocs/auth_bloc/auth_event.dart';
import 'package:anonymous_chat/presentation/blocs/auth_bloc/auth_state.dart';
import 'package:anonymous_chat/presentation/widgets/custom_button.dart';
import 'package:anonymous_chat/presentation/widgets/custom_error_snackbar.dart';
import 'package:anonymous_chat/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteAccountBottomSheet extends StatefulWidget {
  const DeleteAccountBottomSheet({super.key});

  @override
  State<DeleteAccountBottomSheet> createState() =>
      _DeleteAccountBottomSheetState();
}

class _DeleteAccountBottomSheetState extends State<DeleteAccountBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _passwordTextFormController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400 + MediaQuery.of(context).viewInsets.bottom,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, authState) {
            if (authState is AuthStateAuthorized &&
                authState.exception
                    is AuthExceptionAccountDeletingWithWrongCredentials) {
              showCustomScnackbar(
                context: context,
                text: authState.exception!.text,
                title: authState.exception!.title,
                isError: true,
              );
            }
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              border: Border.all(
                color: Colors.grey[500]!,
                width: 1.5,
              ),
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: Form(
                key: _formKey,
                child: Column(
                  textDirection: TextDirection.ltr,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Are you sure you want to delete your account?',
                      maxLines: 3,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'To delete an account you need to provide account\'s valid password!',
                      maxLines: 3,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 35),
                    // BlocBuilder<AuthBloc, AuthState>(
                    //   builder: (context, authState) {
                    //     if (authState is AuthStateAuthorized &&
                    //         authState.exception
                    //             is AuthExceptionAccountDeletingWithWrongCredentials) {
                    //       return Column(
                    //         mainAxisSize: MainAxisSize.min,
                    //         children: [
                    //           Text(
                    //             authState.exception!.text,
                    //             maxLines: 3,
                    //             softWrap: true,
                    //             overflow: TextOverflow.ellipsis,
                    //             style: const TextStyle(
                    //               color: Colors.red,
                    //               fontSize: 15,
                    //             ),
                    //           ),
                    //           const SizedBox(height: 5),
                    //         ],
                    //       );
                    //     }
    
                    //     return const SizedBox.shrink();
                    //   },
                    // ),
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
                      text: 'Delete account',
                      backgroundColor: Colors.red,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<AuthBloc>(context).add(
                            AuthEventDeleteAccount(
                              password: _passwordTextFormController.text,
                            ),
                          );
    
                          // Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
