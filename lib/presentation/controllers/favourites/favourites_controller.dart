import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../../../data/models/character_hive_model.dart';
import '../../../domain/entities/character_entity.dart';

class FavoritesController extends GetxController {
  final Box<CharacterHiveModel> favoritesBox = Hive.box<CharacterHiveModel>(
    'favorites',
  );

  var favorites = <CharacterHiveModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  void loadFavorites() {
    favorites.value = favoritesBox.values.toList();
  }

  void addFavorite(CharacterHiveModel character) {
    if (!favoritesBox.values.any((c) => c.id == character.id)) {
      favoritesBox.put(character.id, character);
      favorites.add(character);
      Get.snackbar(
        '',
        '${character.name} added to favorites',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.grey,
        colorText: Colors.black,
        titleText: Text(
          "Added",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      );
    }
  }

  void removeFavorite(int characterId) {
    favoritesBox.delete(characterId);
    favorites.removeWhere((c) => c.id == characterId);
    Get.snackbar(
      '',
      'Character removed from favorites',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.grey,
      colorText: Colors.black,
      titleText: Text(
        "Removed",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

  bool isFavorite(int characterId) {
    return favoritesBox.containsKey(characterId);
  }

  void updateFavorite(CharacterEntity updatedCharacter) {
    if (favoritesBox.containsKey(updatedCharacter.id)) {
      final updatedHiveModel = CharacterHiveModel.fromEntity(updatedCharacter);
      favoritesBox.put(updatedCharacter.id, updatedHiveModel);

      final index = favorites.indexWhere((c) => c.id == updatedCharacter.id);
      if (index != -1) {
        favorites[index] = updatedHiveModel;
        favorites.refresh();
      }
    }
  }
}
