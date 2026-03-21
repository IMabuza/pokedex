import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login", style: TextStyle(fontSize: 24),),
              SizedBox(height: 20,),
              TextField(
                decoration: InputDecoration(label: Text("Email")),
              ),
              TextField(
                 decoration: InputDecoration(label: Text("Password")),
              ),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: (){}, child: Text('Login')),
              TextButton(onPressed: (){}, child: Text("Don't have an account? Register here."))
            ],
          ),
        ),
      ),
    );
  }
}