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
          title: 'User alreast exists',
          text: 'User with such email alreast exists!',
        );
}

class AuthExceptionAccountDeleting extends AuthException {
  AuthExceptionAccountDeleting()
      : super(
          title: 'Account deleting exception',
          text: 'Something happened while deleting user data.',
        );
}

class AuthExceptionAccountDeletingWithWrongCredentials extends AuthException {
  AuthExceptionAccountDeletingWithWrongCredentials()
      : super(
          title: 'Wrong password',
          text: 'You can not delete account with wrong password!',
        );
}
