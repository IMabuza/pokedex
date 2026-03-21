part of 'auth_bloc.dart';

class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}


class SignIn extends AuthEvent {
  final String email;
  final String password;

  const SignIn(this.email, this.password);
}