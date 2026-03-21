import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/features/auth/views/login_screen.dart';
import 'package:pokedex/features/auth/views/register_screen.dart';

GoRouter router(BuildContext context) {
  return GoRouter(
    initialLocation: "/",
    routes: [
    GoRoute(path: "/", name: "login", builder: (context, state) => LoginScreen(),),
    GoRoute(path: "/register", name: "register", builder: (context, state) => RegisterScreen(),)
  ]);
}