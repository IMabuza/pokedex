import 'package:flutter/material.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({
    super.key,
    required TextEditingController passwordController,
  }) : _passwordController = passwordController;

  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _passwordController,
      decoration: InputDecoration(label: Text("Password"), counterText: ""),
      maxLength: 20,
      obscureText: true,
      validator: (value) {
        if (value == null || value.length < 8) {
          return "Password is too short";
        }
        return null;
      },
    );
  }
}
