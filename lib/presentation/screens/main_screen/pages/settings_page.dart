import 'package:anonymous_chat/core/erorrs/auth_exception.dart';
import 'package:anonymous_chat/domain/entities/user/user.dart';
import 'package:anonymous_chat/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:anonymous_chat/presentation/blocs/auth_bloc/auth_event.dart';
import 'package:anonymous_chat/presentation/blocs/auth_bloc/auth_state.dart';
import 'package:anonymous_chat/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:anonymous_chat/presentation/blocs/user_bloc/user_state.dart';
import 'package:anonymous_chat/presentation/screens/main_screen/pages/widgets/delete_account_bottom_sheet.dart';
import 'package:anonymous_chat/presentation/screens/main_screen/pages/widgets/settings_page_account_form.dart';
import 'package:anonymous_chat/presentation/widgets/bottom_sheet_controller.dart';
import 'package:anonymous_chat/presentation/widgets/custom_button.dart';
import 'package:anonymous_chat/presentation/widgets/custom_error_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocListener(
        listeners: [
          BlocListener<UserBloc, UserState>(
            listener: (context, userState) {
              if (userState is UserStateInitialized &&
                  userState.exception != null) {
                showCustomScnackbar(
                  context: context,
                  text: userState.exception!.text,
                  title: userState.exception!.title,
                  isError: true,
                );
              }

              if (userState is UserStateUpdated) {
                showCustomScnackbar(
                  context: context,
                  text: 'You have updated your account data!',
                  title: 'Saved',
                  isError: false,
                );
              }
            },
          ),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, authState) {
              if (authState is AuthStateAuthorized &&
                  authState.exception != null &&
                  authState.exception
                      is! AuthExceptionAccountDeletingWithWrongPassword) {
                showCustomScnackbar(
                  context: context,
                  text: authState.exception!.text,
                  title: authState.exception!.title,
                  isError: true,
                );
              }
            },
          ),
        ],
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
              BlocBuilder<UserBloc, UserState>(
                builder: (context, userState) {
                  if (userState.user?.authMethod != AuthMethod.guest) {
                    return CustomButton(
                      onPressed: () {
                        BlocProvider.of<AuthBloc>(context).add(
                          const AuthEventSignOut(),
                        );
                      },
                      text: 'Sign Out',
                      backgroundColor: Colors.blue,
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(height: 20),
              CustomButton(
                onPressed: () {
                  BottomSheetController.showBottomSheet(
                    context: context,
                    widget: const DeleteAccountBottomSheet(),
                  );
                },
                text: 'Delete account',
                backgroundColor: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
