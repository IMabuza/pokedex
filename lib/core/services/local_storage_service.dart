import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService {
  Future<Box> openBox<T>(String boxName) async {
    return await Hive.openBox<T>(boxName);
  }

  Future<List<dynamic>?> getCachedPokemonData() async {
    final box = Hive.box<List<dynamic>>("allPokemon");
    return box.get("results");
  }

  Future<void> savePokemonData(List<dynamic> data) async {
    final box = Hive.box<List<dynamic>>("allPokemon");
    await box.put("results", data);
  }

  Future<void> saveFavouriteId(String id) async {
    final box = Hive.box<String>("favourites");
    await box.put(id, id);
  }

  Future<List<String>> getAllFavouriteIds() async {
    final box = Hive.box<String>("favourites");
    return box.values.toList();
  }

  Future<void> removeFavouriteId(String id) async {
    final box = Hive.box<String>("favourites");
    box.delete(id);
  }

  Future<void> saveTheme(bool isDarkTheme) async {
    final box = Hive.box<bool>("theme");
    await box.put("isDarkTheme", isDarkTheme);
  }

  bool? isDartTheme() {
    final box = Hive.box<bool>("theme");
    return box.get("isDarkTheme");
  }
}
