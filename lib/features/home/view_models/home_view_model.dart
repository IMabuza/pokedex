import 'package:pokedex/features/home/bloc/home_bloc.dart';
import 'package:pokedex/features/home/bloc/theme/theme_bloc.dart';

class HomeViewModel {
  HomeBloc _homeBloc;
  ThemeBloc _themeBloc;
  HomeViewModel(this._homeBloc, this._themeBloc);

  void loadPokemons(bool isFavourites){
    _homeBloc.add(LoadPokemons(isFavourites));
  }

  void changeTheme(bool isDarkMode){
    _themeBloc.add(ThemeToggle(isDarkMode));
  }

  void search(String name){
    _homeBloc.add(Search(name));
  }
}