import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pokedex/features/home/models/pokemon_list_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ApiService {
  static const baseUrl = "https://pokeapi.co/api/v2";

  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<List<dynamic>> fetchPokemon() async {
    try {

        final response = await _dio.get(
          "/pokemon",
          queryParameters: {"limit": 10000},
        );

        final data = response.data["results"];

      return data;
    } on DioException catch (e) {
      throw Exception("Could not fetch Pokemon: ${e.message} ");
    }
  }

  Future<PokemonListItem?> fetchPokemonByName(String name) async {
    final response = await _dio.get("/pokemon/${name}");

    final data = response.data["forms"];

    final result = PokemonListItem.fromJson(data[0]);

    return result;
  }
}
