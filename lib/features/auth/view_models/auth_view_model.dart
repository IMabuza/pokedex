import 'package:flutter/material.dart';
import 'package:pokedex/features/auth/bloc/auth_bloc.dart';

class AuthViewModel {
  final AuthBloc _authBloc;
  AuthViewModel(this._authBloc);

  final _loginFormKey = GlobalKey<FormState>();
  final _registerFormKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _loginFormKey;
  GlobalKey<FormState> get registerFormKey => _registerFormKey;

  void login(String email, String password) {
    if (!_loginFormKey.currentState!.validate()) {
      return;
    }

    _authBloc.add(SignIn(email, password));
  }

  void register(String email, String password, String confirmPassword) {
    if (!_registerFormKey.currentState!.validate()) {
      return;
    }

    _authBloc.add(Register(email, password, confirmPassword));
  }

  void reset(){
    _authBloc.add(Reset());
  }
}
