part of 'home_bloc.dart';

class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}


class LoadPokemons extends HomeEvent{
  final int limit;
  final int offSet;

  const LoadPokemons(this.limit, this.offSet);
}
