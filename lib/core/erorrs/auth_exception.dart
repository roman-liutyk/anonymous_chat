class AuthException {
  AuthException({
    this.title = 'Auth exception',
    this.text = 'Something happened',
  });

  final String title;
  final String text;
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
