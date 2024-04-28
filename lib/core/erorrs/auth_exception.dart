import 'package:anonymous_chat/core/erorrs/custom_exception.dart';

class AuthException extends CustomException {
  AuthException({
    super.title = 'Auth exception',
    super.text = 'Something happened',
  });
}

class AuthExceptionWrongPassword extends AuthException {
  AuthExceptionWrongPassword()
      : super(
          title: 'Wrong password',
          text: 'Password is wrong, please try again!',
        );
}

class AuthExceptionUserDoesNotExist extends AuthException {
  AuthExceptionUserDoesNotExist()
      : super(
          title: 'User does not exist',
          text: 'User with such email does not exist!',
        );
}

class AuthExceptionUserAlreadyExists extends AuthException {
  AuthExceptionUserAlreadyExists()
      : super(
          title: 'User already exists',
          text: 'User with such email already exists!',
        );
}

class AuthExceptionAccountDeleting extends AuthException {
  AuthExceptionAccountDeleting()
      : super(
          title: 'Account deleting exception',
          text: 'Something happened while deleting user data.',
        );
}

class AuthExceptionAccountDeletingWithWrongPassword extends AuthException {
  AuthExceptionAccountDeletingWithWrongPassword()
      : super(
          title: 'Wrong password',
          text: 'You can not delete account with wrong password!',
        );
}

class AuthExceptionDeletingWithoutProvidedCredentials extends AuthException {
  AuthExceptionDeletingWithoutProvidedCredentials()
      : super(
          title: 'Account deleting failed',
          text: 'You have to provide credentials to delete your account.',
        );
}

class AuthExceptionGuestSigningIn extends AuthException {
  AuthExceptionGuestSigningIn()
      : super(
          title: 'Guest signing in failed',
          text: 'Something happened while signing in as guest.',
        );
}

class AuthExceptionSigningInWithGoogle extends AuthException {
  AuthExceptionSigningInWithGoogle()
      : super(
          title: 'Google signing in failed',
          text: 'Something happened while signing in with Google.',
        );
}
