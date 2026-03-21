import 'package:flutter/material.dart';
import 'package:pokedex/features/auth/bloc/auth_bloc.dart';

class AuthViewModel {
  final AuthBloc _authBloc;
  AuthViewModel(this._authBloc);

  final _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;

  void login(String email, String password) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _authBloc.add(SignIn(email, email));
  }
}
