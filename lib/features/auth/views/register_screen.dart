import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Register", style: TextStyle(fontSize: 24)),
              SizedBox(height: 20),
              TextField(decoration: InputDecoration(label: Text("Email"))),
              TextField(decoration: InputDecoration(label: Text("Password"))),
              SizedBox(height: 20),
              ElevatedButton(onPressed: () {}, child: Text('Register')),
              TextButton(
                onPressed: () =>
                    context.goNamed("login"),
                child: Text("Already Have an account? Login here."),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
