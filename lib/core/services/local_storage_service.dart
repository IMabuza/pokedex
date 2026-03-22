import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService {
  Future<Box> openBox(String boxName) async {
    return await Hive.openBox<List<dynamic>>(boxName);
  } 

  Future<List<dynamic>?> getCachedPokemonData() async {
    final box = Hive.box<List<dynamic>>("allPokemon");
    return box.get("results");
  }


  Future<void> savePokemonData(List<dynamic> data) async{
       final box = Hive.box<List<dynamic>>("allPokemon");
    await box.put("results", data);
  }


}