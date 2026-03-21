part of 'home_bloc.dart';

 class HomeState extends Equatable {
  const HomeState();  

  @override
  List<Object> get props => [];
}
class HomeInitial extends HomeState {}

class HomeLoading extends HomeState{
    final bool isInitialLoad;
    const HomeLoading(this.isInitialLoad);
}

class HomeLoaded extends HomeState{
  final List<PokemonListItem> items;

  const HomeLoaded(this.items);
}

class HomeError extends HomeState{
  final String errorMessage;
  const HomeError(this.errorMessage);
}
