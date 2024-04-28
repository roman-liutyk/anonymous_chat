
import 'package:anonymous_chat/core/erorrs/custom_exception.dart';

class AuthState {
  const AuthState();
}

class AuthStateAuthorized extends AuthState {
  const AuthStateAuthorized({
    this.exception,
  });
  
  final CustomException? exception;
}

class AuthStateUnauthorized extends AuthState {
  const AuthStateUnauthorized({
    this.exception,
  });

  final CustomException? exception;
}
