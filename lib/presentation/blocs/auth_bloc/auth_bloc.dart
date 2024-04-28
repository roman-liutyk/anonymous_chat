import 'dart:developer';

import 'package:anonymous_chat/core/erorrs/auth_exception.dart';
import 'package:anonymous_chat/core/erorrs/user_exception.dart';
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
      final bool isSuccessful = await _authRepository.signIn(
        email: event.email,
        password: event.password,
      );

      if (isSuccessful) {
        emit(const AuthStateAuthorized());
      }
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
      // TODO add email verification

      final bool isSuccessful = await _authRepository.signUp(
        email: event.email,
        password: event.password,
      );

      if (isSuccessful) {
        emit(const AuthStateAuthorized());
      }
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
    try {
      final bool isSuccessful = await _authRepository.deleteAccount(
        password: event.password,
      );

      if (isSuccessful) {
        _userRepository.clearCurrentUser();
        emit(const AuthStateUnauthorized());
      }
    } on AuthException catch (authException) {
      log('1 $authException');
      emit(AuthStateAuthorized(exception: authException));
    } on UserException catch (userException) {
      log('2 $userException');
      emit(AuthStateAuthorized(exception: userException));
    } catch (exception) {
      log('3 $exception');
      emit(const AuthStateAuthorized());
    }
  }
}
