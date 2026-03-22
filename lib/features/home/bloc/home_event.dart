part of 'home_bloc.dart';

class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}


class LoadPokemons extends HomeEvent{}

class Search extends HomeEvent {
  final String name;

  const Search(this.name);
}
