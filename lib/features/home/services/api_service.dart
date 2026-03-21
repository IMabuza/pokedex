import 'package:dio/dio.dart';
import 'package:pokedex/features/home/models/pokemon_list_item.dart';

class ApiService {
  static const baseUrl = "https://pokeapi.co/api/v2";

  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<List<PokemonListItem>> fetchPokemon(int offset) async {
    try {
      final response = await _dio.get(
        "/pokemon",
        queryParameters: {"offset": offset, "limit": 20},
      );

      final data = response.data["results"] as List;

      final result = data.map((p) => PokemonListItem.fromJson(p)).toList();

      return result;
    } on DioException catch (e) {
      throw Exception("Could not fetch Pokemon: ${e.message} ");
    }
  }
}
