import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex/core/services/local_storage_service.dart';
import 'package:pokedex/features/home/services/api_service.dart';
import 'package:pokedex/features/pokemon_details/models/pokemon.dart';

part 'pokemon_details_event.dart';
part 'pokemon_details_state.dart';

class PokemonDetailsBloc
    extends Bloc<PokemonDetailsEvent, PokemonDetailsState> {
  final ApiService _apiService;
  final LocalStorageService _localStorageService;
  PokemonDetailsBloc(this._apiService, this._localStorageService) : super(PokemonDetailsInitial()) {
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
        final faveIds = await _localStorageService.getAllFavouriteIds();
        if(faveIds.contains(event.name)){
          data.isFavourite = true;
        }
        emit(PokemonDetailsLoaded(data));
      }
    } catch (e) {
      PokemonDetailsError("Faled to load Pokemon details. Try again");
    }
  }
}
