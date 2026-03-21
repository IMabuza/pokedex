import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/core/widgets/primary_button.dart';
import 'package:pokedex/features/auth/view_models/auth_view_model.dart';
import 'package:pokedex/features/auth/widgets/email_input.dart';
import 'package:pokedex/features/auth/widgets/password_input.dart';

import '../bloc/auth_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  late final AuthViewModel authViewModel;
  late AuthBloc authBloc;

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
                  Text("Register", style: TextStyle(fontSize: 24)),
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
                    key: authViewModel.registerFormKey,
                    child: Column(
                      children: [
                        EmailInput(emailController: _emailController),
                        PasswordInput(passwordController: _passwordController),
                        PasswordInput(
                          passwordController: _confirmPasswordController,
                          label: "Confirm Password",
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),
                  PrimaryButton(
                    isLoading: state is AuthLoading,
                    onPress: () => authViewModel.register(
                      _emailController.text,
                      _passwordController.text,
                      _confirmPasswordController.text
                    ),
                    buttonText: "Register",
                  ),
                  TextButton(
                    onPressed: ()  {
                      context.goNamed("login");
                      authViewModel.reset();
                    },
                    child: Text("Already Have an account? Login here."),
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
