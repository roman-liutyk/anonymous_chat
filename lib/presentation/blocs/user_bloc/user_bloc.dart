import 'package:anonymous_chat/core/erorrs/user_exception.dart';
import 'package:anonymous_chat/domain/entities/user/user.dart';
import 'package:anonymous_chat/domain/repositories.dart/user_repository.dart';
import 'package:anonymous_chat/presentation/blocs/user_bloc/user_event.dart';
import 'package:anonymous_chat/presentation/blocs/user_bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(UserStateEmpty()) {
    on<UserEventInitialize>(_init);
    on<UserEventUpdateData>(_updateData);
    on<UserEventClearState>(_clearState);
  }

  final UserRepository _userRepository;

  Future<void> _init(
    UserEventInitialize event,
    Emitter<UserState> emit,
  ) async {
    try {
      final User user = await _userRepository.getCurrentUser();

      emit(UserStateInitialized(user: user));
    } catch (exception) {
      emit(UserStateEmpty());
    }
  }

  Future<void> _updateData(
    UserEventUpdateData event,
    Emitter<UserState> emit,
  ) async {
    try {
      final User user = await _userRepository.updateUserData(
        username: event.username,
        email: event.email,
      );

      emit(UserStateUpdated(user: user));
    } on UserException catch (userException) {
      emit(UserStateInitialized(
        user: state.user!,
        exception: userException,
      ));
    } catch (exception) {
      emit(UserStateInitialized(
        user: state.user!,
        exception: UserExceptionDataUpdating(),
      ));
    }
  }
  
  Future<void> _clearState(
    UserEventClearState event,
    Emitter<UserState> emit,
  ) async {
    _userRepository.clearCurrentUser();
    emit(UserStateEmpty());
  }
}
