import 'package:anonymous_chat/core/erorrs/auth_exception.dart';

class AuthState {
  const AuthState();
}

class AuthStateAuthorized extends AuthState {
  const AuthStateAuthorized({
    this.exception,
  });
  
  final AuthException? exception;
}

class AuthStateUnauthorized extends AuthState {
  const AuthStateUnauthorized({
    this.exception,
  });

  final AuthException? exception;
}
