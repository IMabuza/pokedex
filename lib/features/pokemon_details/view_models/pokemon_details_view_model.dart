import 'package:pokedex/features/pokemon_details/bloc/pokemon_details_bloc.dart';

class PokemonDetailsViewModel {
  PokemonDetailsBloc _pokemonDetailsBloc;
  PokemonDetailsViewModel(this._pokemonDetailsBloc);

  void loadPokemonDetails(String name){
    _pokemonDetailsBloc.add(LoadPokemonDetails(name));
  }
}