import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex/core/services/local_storage_service.dart';
import 'package:pokedex/features/home/models/pokemon_list_item.dart';
import 'package:pokedex/features/home/services/api_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApiService _apiService;
  final LocalStorageService _localStorageService;
  List<PokemonListItem> items = [];
  List<PokemonListItem> faves = [];
  int limit = 20;
  HomeBloc(this._apiService, this._localStorageService) : super(HomeInitial()) {
    on<LoadPokemons>(_onLoadPokemons);
    on<Search>(_onSearch);
  }

  Future<void> _onLoadPokemons(
    LoadPokemons event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(HomeLoading(limit == 20));

      await _localStorageService.openBox<List<dynamic>>("allPokemon");
      await _localStorageService.openBox<String>("favourites");
      List<dynamic>? cachedData = await _localStorageService
          .getCachedPokemonData();

      if (cachedData == null) {
        final data = await _apiService.fetchPokemon();
        await _localStorageService.savePokemonData(data);
        cachedData = await _localStorageService.getCachedPokemonData();
      }

      List<String> faveIds = await _localStorageService.getAllFavouriteIds();

      final result = cachedData!.map((c) {
        final Map<String, dynamic> pokemonMap = Map<String, dynamic>.from(c);
        final pokemon = PokemonListItem.fromJson(pokemonMap);
        pokemon.isFavourite = faveIds.contains(pokemon.name);
        return pokemon;
      }).toList();

      if (event.isFavourites) {
        faves = (faves.toSet()..addAll(result.where((p) => p.isFavourite))).toList();
        emit(HomeLoaded(faves.take(limit).toList()));
      } else {
        items = (items.toSet()..addAll(result)).toList();
        emit(HomeLoaded(items.take(limit).toList()));
      }

      limit += 20;
    } catch (e) {
      emit(HomeError("Failed to load Pokemon"));
    }
  }

  Future<void> _onSearch(Search event, Emitter<HomeState> emit) async {
    try {
      emit(HomeLoading(false));
      final data = await _localStorageService.getCachedPokemonData();

      final result = data!.map((c) {
        final Map<String, dynamic> pokemonMap = Map<String, dynamic>.from(c);
        return PokemonListItem.fromJson(pokemonMap);
      }).toList();

      final filter = result.where(
        (item) => item.name.contains(event.name.toLowerCase()),
      );

      emit(HomeLoaded(filter.toList()));
    } catch (_) {
      emit(HomeError("Failed to search"));
    }
  }
}
