import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/features/home/bloc/home_bloc.dart';
import 'package:pokedex/features/home/bloc/theme/theme_bloc.dart';
import 'package:pokedex/features/home/view_models/home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeViewModel homeViewModel;
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    final themeBloc = BlocProvider.of<ThemeBloc>(context);
    homeViewModel = HomeViewModel(homeBloc, themeBloc);
    homeViewModel.loadPokemons();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pokédex"), actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              setState(() {
                isDarkMode = !isDarkMode;
                homeViewModel.changeTheme(isDarkMode);
              });
            },
            child: isDarkMode ? Icon(Icons.dark_mode) : Icon(Icons.light_mode)),
        )
      ],),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is HomeLoaded) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(state.items[index].name),
                      leading: Image(
                        image: NetworkImage(
                          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/${state.items[index].id}.png",
                        ),
                      ),
                    ),
                    Divider()
                  ],
                );
              },
              itemCount: state.items.length,
            );
          }

          if (state is HomeError) {
            return Center(child: Text("Error loading pokemon"));
          }

          return SizedBox.shrink();
        },
      ),
    );
  }
}
