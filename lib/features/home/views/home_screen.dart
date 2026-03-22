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
  bool isFavourites = false;

  @override
  void initState() {
    super.initState();
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    final themeBloc = BlocProvider.of<ThemeBloc>(context);
    homeViewModel = HomeViewModel(homeBloc, themeBloc);
    homeViewModel.loadPokemons(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokédex"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    homeViewModel.changeTheme(isDarkMode);
                    setState(() {
                      isDarkMode = !isDarkMode;
                    });
                  },
                  child: isDarkMode
                      ? Icon(Icons.light_mode)
                      : Icon(Icons.dark_mode),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    homeViewModel.loadPokemons(isFavourites);
                    setState(() {
                      isFavourites = !isFavourites;
                    });
                  },
                  child: Icon(
                    isFavourites ? Icons.favorite : Icons.favorite_border,
                    color: isFavourites ? Colors.red : Colors.grey,
                  ),
                ),
              ],
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
                    child: Icon(Icons.search),
                  ),
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
                  if (state.items.isEmpty) {
                    return Center(child: Text("No Pokemon found"));
                  }
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ItemTile(
                            id: state.items[index].id,
                            name: state.items[index].name,
                          ),
                          Divider(),
                          if (index ==
                              state.items.indexOf(
                                state.items.reversed.elementAt(0),
                              ))
                            PrimaryButton(
                              onPress: () =>
                                  homeViewModel.loadPokemons(isFavourites),
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

class ItemTile extends StatelessWidget {
  const ItemTile({super.key, required this.name, required this.id});

  final String name;
  final String id;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push("/pokemon/$name"),
      child: ListTile(
        key: PageStorageKey("home_list"),
        title: Text(name),
        leading: CachedNetworkImage(
          errorWidget: (context, url, error) => Icon(Icons.error),
          placeholder: (context, url) => CircularProgressIndicator(),
          width: 50,
          height: 50,

          imageUrl:
              "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/$id.png",
        ),
      ),
    );
  }
}
