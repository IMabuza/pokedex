import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/features/home/bloc/theme/theme_bloc.dart';
import 'package:pokedex/features/pokemon_details/bloc/pokemon_details_bloc.dart';
import 'package:pokedex/features/pokemon_details/view_models/pokemon_details_view_model.dart';

class PokemonDetailsScreen extends StatefulWidget {
  const PokemonDetailsScreen({super.key, required this.pokemonName});
  final String pokemonName;

  @override
  State<PokemonDetailsScreen> createState() => _PokemonDetailsScreenState();
}

class _PokemonDetailsScreenState extends State<PokemonDetailsScreen> {
  late final PokemonDetailsViewModel _pokemonDetailsViewModel;

  @override
  void initState() {
    super.initState();
    final detailsBloc = BlocProvider.of<PokemonDetailsBloc>(context);
    _pokemonDetailsViewModel = PokemonDetailsViewModel(detailsBloc);
    _pokemonDetailsViewModel.loadPokemonDetails(widget.pokemonName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pokemonName),
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: BlocBuilder<PokemonDetailsBloc, PokemonDetailsState>(
        builder: (context, state) {
          if (state is PokemonDetailsLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is PokemonDetailsLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        placeholder: (context, url) => CircularProgressIndicator(),
                        width: 250,
                        height: 250,
                
                        imageUrl: state.pokemon.imageUrl,
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Description",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: 10),
                      Text(
                        state.pokemon.description.replaceAll('\n', " "),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(height: 20),
                      Text("Stats", style: Theme.of(context).textTheme.titleLarge),
                       SizedBox(height: 10),
                      GridView.builder(
                        itemCount: state.pokemon.stats.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Center(child: Column(
                                children: [
                                  Text(state.pokemon.stats[index].name, style: Theme.of(context).textTheme.titleSmall,),
                                  SizedBox(height: 5),
                                  Text("Base stat: ${state.pokemon.stats[index].baseStat}"),
                                   SizedBox(height: 5),
                                  Text("Effort: ${state.pokemon.stats[index].effort}")
                                ],
                              )),
                            ),
                          );
                        },
                      ),
                       SizedBox(height: 20),
                      Text("Types", style: Theme.of(context).textTheme.titleLarge),
                       SizedBox(height: 10),
                       GridView.builder(
                        itemCount: state.pokemon.types.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Center(child: Column(
                                children: [
                                  Text(state.pokemon.types[index].name, style: Theme.of(context).textTheme.titleSmall,),
                                  SizedBox(height: 5),
                                  Text("Slot: ${state.pokemon.types[index].slot}"),
                                  
                                ],
                              )),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          if (state is PokemonDetailsError) {
            return Center(child: Text(state.errorMessage));
          }

          return SizedBox.shrink();
        },
      ),
    );
  }
}
