import 'package:pokedex/features/pokemon_details/models/stat.dart';
import 'package:pokedex/features/pokemon_details/models/type.dart';

class Pokemon {
  final String imageUrl;
  final String description;
  final List<Stat> stats;
  final List<Type> types;
  bool isFavourite;

  Pokemon({
    this.isFavourite = false,

    required this.imageUrl,
    required this.description,
    required this.stats,
    required this.types,
  });

  factory Pokemon.fromJsons(
    Map<String, dynamic> json1,
    Map<String, dynamic> json2,
  ) {
    return Pokemon(
      imageUrl:
          json1['sprites']['other']['official-artwork']["front_default"] ?? '',
      description: json2['flavor_text_entries'][0]['flavor_text'] ?? '',
      stats: List<Stat>.from(json1['stats']?.map((x) => Stat.fromJson(x))),
      types: List<Type>.from(json1['types']?.map((x) => Type.fromJson(x))),
    );
  }
}
