import 'package:anonymous_chat/core/erorrs/auth_exception.dart';
import 'package:anonymous_chat/domain/entities/user_auth_response.dart';
import 'package:anonymous_chat/domain/repositories.dart/auth_repository.dart';
import 'package:anonymous_chat/domain/repositories.dart/user_repository.dart';
import 'package:anonymous_chat/presentation/blocs/auth_bloc/auth_event.dart';
import 'package:anonymous_chat/presentation/blocs/auth_bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        super(const AuthStateUnauthorized()) {
    on<AuthEventInitialize>(_init);
    on<AuthEventSignIn>(_signIn);
    on<AuthEventSignUp>(_signUp);
    on<AuthEventSignOut>(_signOut);
    on<AuthEventDeleteAccount>(_deleteAccount);
  }

  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  Future<void> _init(
    AuthEventInitialize event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final bool isUserAuthorized = await _authRepository.isUserAuthorized();

      if (isUserAuthorized) {
        emit(const AuthStateAuthorized());
      } else {
        emit(const AuthStateUnauthorized());
      }
    } catch (exception) {
      emit(const AuthStateUnauthorized());
    }
  }

  Future<void> _signIn(
    AuthEventSignIn event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final UserAuthResponse userAuthResponse = await _authRepository.signIn(
        email: event.email,
        password: event.password,
      );

      emit(const AuthStateAuthorized());
    } on AuthException catch (authException) {
      emit(AuthStateUnauthorized(exception: authException));
    } catch (exception) {
      emit(const AuthStateUnauthorized());
    }
  }

  Future<void> _signUp(
    AuthEventSignUp event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final UserAuthResponse userAuthResponse = await _authRepository.signUp(
        email: event.email,
        password: event.password,
      );

      emit(const AuthStateAuthorized());
    } on AuthException catch (authException) {
      emit(AuthStateUnauthorized(exception: authException));
    } catch (exception) {
      emit(const AuthStateUnauthorized());
    }
  }

  Future<void> _signOut(
    AuthEventSignOut event,
    Emitter<AuthState> emit,
  ) async {
    await _authRepository.signOut();
    _userRepository.clearCurrentUser();
    emit(const AuthStateUnauthorized());
  }

  Future<void> _deleteAccount(
    AuthEventDeleteAccount event,
    Emitter<AuthState> emit,
  ) async {
    await _authRepository.deleteAccount();
    _userRepository.clearCurrentUser();
    emit(const AuthStateUnauthorized());
  }
}
