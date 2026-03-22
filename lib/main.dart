import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex/core/bloc/favourite_bloc.dart';
import 'package:pokedex/core/services/local_storage_service.dart';
import 'package:pokedex/features/auth/bloc/auth_bloc.dart';
import 'package:pokedex/features/auth/services/auth_service.dart';
import 'package:pokedex/features/home/bloc/home_bloc.dart';
import 'package:pokedex/features/home/bloc/theme/theme_bloc.dart';
import 'package:pokedex/features/home/services/api_service.dart';
import 'package:pokedex/features/pokemon_details/bloc/pokemon_details_bloc.dart';
import 'package:pokedex/firebase_options.dart';
import 'package:pokedex/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(AuthService())),
        BlocProvider(create: (context) => HomeBloc(ApiService(), LocalStorageService())),
        BlocProvider(create: (context) => ThemeBloc(LocalStorageService())..add(LoadTheme())),
        BlocProvider(create: (context) => PokemonDetailsBloc(ApiService(), LocalStorageService())),
        BlocProvider(create: (context) => FavouriteBloc(LocalStorageService()))
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromARGB(255, 15, 86, 66),
                brightness: state is ThemeDark ? Brightness.dark : Brightness.light,
              ),
            ),
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
