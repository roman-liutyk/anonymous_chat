import 'package:anonymous_chat/core/erorrs/custom_exception.dart';
import 'package:anonymous_chat/domain/entities/user.dart';

class UserState {
  const UserState({
    required this.user,
  });

  final User? user;
}

class UserStateEmpty extends UserState {
  UserStateEmpty({
    this.exception,
  }) : super(user: null);

  final CustomException? exception;
}

class UserStateInitialized extends UserState {
  UserStateInitialized({
    required User user,
    this.exception,
  }): super(user: user);

  final CustomException? exception;
}

class UserStateUpdated extends UserState {
  UserStateUpdated({
    required User user,
  }): super(user: user);

}
