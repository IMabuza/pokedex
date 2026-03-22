import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/features/auth/views/login_screen.dart';
import 'package:pokedex/features/auth/views/register_screen.dart';
import 'package:pokedex/features/home/views/home_screen.dart';
import 'package:pokedex/features/pokemon_details/views/pokemon_details_screen.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
        path: "/",
        name: "login",
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: "/register",
        name: "register",
        builder: (context, state) => RegisterScreen(),
      ),
      GoRoute(
        path: "/home",
        name: "home",
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: "/pokemon/:name",
        name: "details",
        builder: (context, state) {
          final name = state.pathParameters["name"] as String;
          return PokemonDetailsScreen(pokemonName: name);
        },
      ),
    ],
  );

  static GoRouter get router => _router;
}
