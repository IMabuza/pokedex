import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/core/widgets/primary_button.dart';
import 'package:pokedex/features/auth/bloc/auth_bloc.dart';

import '../viewModels/auth_view_model.dart';
import '../widgets/email_input.dart';
import '../widgets/password_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthBloc authBloc;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late final AuthViewModel authViewModel;

  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);
    authViewModel = AuthViewModel(authBloc);
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                context.goNamed('home');
              }
            },
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Login", style: TextStyle(fontSize: 24)),
                  SizedBox(height: 20),
                  if (state is AuthError)
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        state.errorMessage,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                  Form(
                    key: authViewModel.formKey,
                    child: Column(
                      children: [
                        EmailInput(emailController: _emailController),
                        PasswordInput(passwordController: _passwordController),
                        SizedBox(height: 20),
                        PrimaryButton(onPress: () => authViewModel.login(_emailController.text, _passwordController.text), isLoading: state is AuthLoading,),
                      ],
                    ),
                  ),

                  TextButton(
                    onPressed: () => context.goNamed("register"),
                    child: Text("Don't have an account? Register here."),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

