import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex/core/services/local_storage_service.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  final LocalStorageService _localStorageService;
  FavouriteBloc(this._localStorageService) : super(FavouriteInitial()) {
    on<Favourite>(_onFavourite);
    on<UnFavourite>(_onUnFavourite);
  }

  Future<void> _onFavourite(
    Favourite event,
    Emitter<FavouriteState> emit,
  ) async {
    await _localStorageService.saveFavouriteId(event.id);
    emit(FavouriteSuccess());
  }

  Future<void> _onUnFavourite(
    UnFavourite event,
    Emitter<FavouriteState> emit,
  ) async {
    await _localStorageService.removeFavouriteId(event.name);
    emit(FavouriteSuccess());
  }
}
