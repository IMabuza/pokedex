import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/features/auth/bloc/auth_bloc.dart';
import 'package:pokedex/features/auth/services/auth_service.dart';
import 'package:pokedex/firebase_options.dart';
import 'package:pokedex/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final routerConfig = router(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(AuthService()))
      ],
      child: MaterialApp.router(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 15, 86, 66),
            brightness: Brightness.dark,
          ),
        ),
        routerConfig: routerConfig,
      ),
    );
  }
}
