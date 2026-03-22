import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pokedex/features/home/models/pokemon_list_item.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex/features/pokemon_details/models/pokemon.dart';

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

  Future<Pokemon?> fetchPokemonByName(String name) async {
    try {
      final response = await Future.wait([
        _dio.get("/pokemon/$name"),
        _dio.get("/pokemon-species/$name"),
      ]);


      final physicalData = response[0].data;

      final speciesData = response[1].data;


   

      final result = Pokemon.fromJsons(physicalData, speciesData);


      return result;
    } on DioException catch (e) {
      throw Exception("Could not fetch Pokemon details: ${e.message} ");
    }
  }
}
