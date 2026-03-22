part of 'pokemon_details_bloc.dart';

class PokemonDetailsEvent extends Equatable {
  const PokemonDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadPokemonDetails extends PokemonDetailsEvent{
  final String name;
  const LoadPokemonDetails(this.name);
}


