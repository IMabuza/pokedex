import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex/features/home/services/api_service.dart';
import 'package:pokedex/features/pokemon_details/models/pokemon.dart';

part 'pokemon_details_event.dart';
part 'pokemon_details_state.dart';

class PokemonDetailsBloc
    extends Bloc<PokemonDetailsEvent, PokemonDetailsState> {
  final ApiService _apiService;
  PokemonDetailsBloc(this._apiService) : super(PokemonDetailsInitial()) {
    on<LoadPokemonDetails>(_onLoadPokemonDetails);
  }

  Future<void> _onLoadPokemonDetails(
    LoadPokemonDetails event,
    Emitter<PokemonDetailsState> emit,
  ) async {
    try {
      emit(PokemonDetailsLoading());
      final data = await _apiService.fetchPokemonByName(event.name);

      if (data != null) {
        emit(PokemonDetailsLoaded(data));
      }
    } catch (e) {
      PokemonDetailsError("Faled to load Pokemon details. Try again");
    }
  }
}
