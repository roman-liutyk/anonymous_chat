class AuthEvent {
  const AuthEvent();
}

class AuthEventInitialize extends AuthEvent {
  const AuthEventInitialize();
}

class AuthEventSignIn extends AuthEvent {
  const AuthEventSignIn({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}

class AuthEventSignUp extends AuthEvent {
  const AuthEventSignUp({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}

class AuthEventSignOut extends AuthEvent {
  const AuthEventSignOut();
}

class AuthEventDeleteAccount extends AuthEvent {
  const AuthEventDeleteAccount();
}
