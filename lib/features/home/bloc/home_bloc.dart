import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/features/home/models/pokemon_list_item.dart';
import 'package:pokedex/features/home/services/api_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApiService _apiService;
  final List<PokemonListItem> items = [];
  int offset = 0;
  HomeBloc(this._apiService) : super(HomeInitial()) {
    on<LoadPokemons>(_onLoadPokemons);
  }

  Future<void> _onLoadPokemons(
    LoadPokemons event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(HomeLoading(offset == 0));

      final data = await _apiService.fetchPokemon(offset);
      items.addAll(data);
      emit(HomeLoaded(items));
      offset += 20;
    } catch (e) {
      emit(HomeError("Failed to load Pokemon"));
    }
  }
}
