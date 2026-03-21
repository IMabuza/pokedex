import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial()) {
  on<ThemeToggle>(_onThemeToggle);
  }

  FutureOr<void> _onThemeToggle(ThemeToggle event, Emitter<ThemeState> emit) {
    if(event.isDarkMode){
      emit(ThemeLight());
    }else{
      emit(ThemeDark());
    }
  }
}
