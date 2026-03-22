part of 'favourite_bloc.dart';

class FavouriteEvent extends Equatable {
  const FavouriteEvent();

  @override
  List<Object> get props => [];
}

class Favourite extends FavouriteEvent {
  final String id;

  const Favourite(this.id);
}

class UnFavourite extends FavouriteEvent {
  final String name;

  const UnFavourite(this.name);
}
