import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/core/widgets/primary_button.dart';
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
  final _searchController = TextEditingController();
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
      appBar: AppBar(
        title: Text("Pokédex"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  homeViewModel.changeTheme(isDarkMode);
                  isDarkMode = !isDarkMode;
                });
              },
              child: isDarkMode
                  ? Icon(Icons.light_mode)
                  : Icon(Icons.dark_mode),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              keyboardType: TextInputType.text,
              controller: _searchController,
              decoration: InputDecoration(
                suffix: Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: GestureDetector(
                    onTap: () {
                      homeViewModel.search(_searchController.text);
                      _searchController.clear();
                      },
                    child: Icon(Icons.search)),
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  if (state.isInitialLoad) {
                    return Center(child: CircularProgressIndicator());
                  }
                }
                if (state is HomeLoaded) {

                  if(state.items.isEmpty){
                    return Center(
                      child: Text("No Pokemon found"),
                    );
                  }
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () => context.push("/pokemon/${state.items[index].name}"),
                            child: ListTile(
                              key: PageStorageKey("home_list"),
                              title: Text(state.items[index].name),
                              leading: CachedNetworkImage(
                                errorWidget: (context, url, error) => Icon(Icons.error),
                                placeholder: (context, url) => CircularProgressIndicator(),
                                width: 50,
                                height: 50,
                                
                                imageUrl: 
                                  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/${state.items[index].id}.png",
                               
                              ),
                            ),
                          ),
                          Divider(),
                          if (index ==
                              state.items.indexOf(
                                state.items.reversed.elementAt(0),
                              ))
                            PrimaryButton(
                              onPress: () => homeViewModel.loadPokemons(),
                              buttonText: "Load more",
                              isLoading: state is HomeLoading,
                            ),
                        ],
                      );
                    },
                    itemCount: state.items.length,
                  );
                }

                if (state is HomeError) {
                  return Center(child: Text(state.errorMessage));
                }

                return SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
