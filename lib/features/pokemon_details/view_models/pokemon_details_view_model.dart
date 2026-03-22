import 'package:pokedex/core/bloc/favourite_bloc.dart';
import 'package:pokedex/features/pokemon_details/bloc/pokemon_details_bloc.dart';

class PokemonDetailsViewModel {
  final PokemonDetailsBloc _pokemonDetailsBloc;
  final FavouriteBloc _favouriteBloc;
  PokemonDetailsViewModel(this._pokemonDetailsBloc, this._favouriteBloc);

  void loadPokemonDetails(String name){
    _pokemonDetailsBloc.add(LoadPokemonDetails(name));
  }

  void favourite(String name, bool isFavourite){
    if(isFavourite){
      _favouriteBloc.add(UnFavourite(name));
    }else{
       _favouriteBloc.add(UnFavourite(name));
    }
  }
}