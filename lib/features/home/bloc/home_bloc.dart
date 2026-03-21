import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex/features/home/models/pokemon_list_item.dart';
import 'package:pokedex/features/home/services/api_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApiService _apiService;
  HomeBloc(this._apiService) : super(HomeInitial()) {
   on<LoadPokemons>(_onLoadPokemons);
  }

  Future<void> _onLoadPokemons(LoadPokemons event, Emitter<HomeState> emit) async {
    try{

      emit(HomeLoading());
      final data = await _apiService.fetchPokemon();
      emit(HomeLoaded(data));
    }catch(e){
      emit(HomeError("Failed"));
    }
  }
}
