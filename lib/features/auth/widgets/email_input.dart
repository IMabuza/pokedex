import 'package:flutter/material.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({super.key, required TextEditingController emailController})
    : _emailController = emailController;

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(label: Text("Email")),
      validator: (value) {
        final RegExp emailRegex = RegExp(
          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
        );
        if (value == null || value.isEmpty) {
          return "Email is required";
        }

        if (!emailRegex.hasMatch(value)) {
          return "Enter a valid email";
        }

        return null;
      },
    );
  }
}
