part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final AuthUser user;

  const AuthSuccess(this.user);
}

class AuthError extends AuthState {
  final String errorMessage;
  const AuthError(this.errorMessage);
}

class AuthReset extends AuthState{}
