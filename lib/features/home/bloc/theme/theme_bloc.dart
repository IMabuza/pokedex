import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex/core/services/local_storage_service.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final LocalStorageService _localStorageService;
  ThemeBloc(this._localStorageService) : super(ThemeInitial()) {
    on<ThemeToggle>(_onThemeToggle);
    on<LoadTheme>(_onLoadTheme);
  }

  FutureOr<void> _onThemeToggle(ThemeToggle event, Emitter<ThemeState> emit) {
    if (event.isDarkMode) {
      _localStorageService.saveTheme(false);
      emit(ThemeLight());
    } else {
      _localStorageService.saveTheme(true);
      emit(ThemeDark());
    }
  }

  Future<void> _onLoadTheme(LoadTheme event, Emitter<ThemeState> emit) async {
    await _localStorageService.openBox<bool>("theme");
    final isDarkTheme = _localStorageService.isDartTheme();
    if(isDarkTheme != null && isDarkTheme){
      emit(ThemeDark());
    }else{
      emit(ThemeLight());
    }
  }
}
