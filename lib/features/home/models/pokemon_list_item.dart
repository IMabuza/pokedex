import 'package:equatable/equatable.dart';

class PokemonListItem extends Equatable {
  final String name;
  final String url;
  final String id;
  bool isFavourite;

  PokemonListItem({this.isFavourite = false, required this.name, required this.url, required this.id});
   

  factory PokemonListItem.fromJson(Map<String, dynamic> json) {
    return PokemonListItem(
      name: json['name'] ?? '',
      url: json['url'] ?? '',
      id: json['url'].split('/').reversed.elementAt(1),
    );
  }
  
  @override
  List<Object?> get props => [name,url,id];
}
