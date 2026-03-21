class PokemonListItem {
  final String name;
  final String url;
  final String id;

  PokemonListItem({required this.name, required this.url, required this.id});
   

  factory PokemonListItem.fromJson(Map<String, dynamic> json) {
    return PokemonListItem(
      name: json['name'] ?? '',
      url: json['url'] ?? '',
      id: json['url'].split('/').reversed.elementAt(1),
    );
  }
}
