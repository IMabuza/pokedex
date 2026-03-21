import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex/features/auth/services/auth_service.dart';

import '../models/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;
  AuthBloc(this._authService) : super(AuthInitial()) {
    on<SignIn>(_onSignIn);
  }

  Future<void> _onSignIn(SignIn event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      final AuthUser? user = await _authService.signIn(
        event.email,
        event.password,
      );

      if (user != null) {
        emit(AuthSuccess(user));
      }
      
    } catch (e) {
      emit(AuthError("Login failed. Please try again"));
    }
  }
}
