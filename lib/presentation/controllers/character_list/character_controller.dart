import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:rick_morty_character/domain/entities/character_entity.dart';
import '../../../data/models/character_hive_model.dart';
import '../../../domain/usecases/get_characters.dart';
import '../favourites/favourites_controller.dart';

class CharacterController extends GetxController {
  final GetCharacters getCharacters;

  CharacterController(this.getCharacters);

  // Hive box
  late Box<CharacterHiveModel> characterBox;

  // State
  var _characters = <CharacterEntity>[].obs;

  late Stream<BoxEvent> _hiveStream;

  List<CharacterEntity> get characters => _characters;

  var isLoading = false.obs;
  var isMoreLoading = false.obs;
  var currentPage = 1;
  var hasMore = true.obs;

  @override
  void onInit() {
    super.onInit();
    _initHiveAndLoad();
  }

  Future<void> _initHiveAndLoad() async {
    isLoading.value = true;
    characterBox = await Hive.openBox<CharacterHiveModel>('characters');
    // Load local data first
    final localData =
    characterBox.values.map((e) => e.toEntity()).toList();

    if (localData.isNotEmpty) {
      _characters.assignAll(localData);
    }
    // _characters.assignAll(
    //   characterBox.values.map((e) => e.toEntity()).toList(),
    // );
    // LISTEN TO HIVE CHANGES
    _hiveStream = characterBox.watch();

    _hiveStream.listen((event) {
      _characters.assignAll(
        characterBox.values.map((e) => e.toEntity()).toList(),
      );
    });

    // Trigger background fetch
    await getCharacters(1);
    if (characterBox.isNotEmpty) {
      // Load from Hive
      isLoading.value = true;
    }
    await Future.delayed(const Duration(seconds: 2));

    isLoading.value = false;
  }

  // Initial Load from API
  Future<void> fetchCharacters() async {
    try {
      isLoading.value = true;

      final result = await getCharacters(currentPage);

      // Save to Hive
      for (var character in result) {
        characterBox.put(
          character.id,
          CharacterHiveModel.fromEntity(character),
        );
      }

      _characters.assignAll(result);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Pagination (Load More)
  Future<void> loadMore() async {
    if (isMoreLoading.value || !hasMore.value) return;

    try {
      isMoreLoading.value = true;
      currentPage++;

      final result = await getCharacters(currentPage);

      if (result.isEmpty) {
        hasMore.value = false;
      } else {
        // Save new characters to Hive
        for (var character in result) {
          characterBox.put(
            character.id,
            CharacterHiveModel.fromEntity(character),
          );
        }

        _characters.addAll(result);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isMoreLoading.value = false;
    }
  }



  // ===== UPDATE CHARACTER METHOD =====
  void updateCharacter(CharacterEntity updatedCharacter) {
    // 1. Update Hive
    characterBox.put(
      updatedCharacter.id,
      CharacterHiveModel.fromEntity(updatedCharacter),
    );

    //  Update List
    final index = _characters.indexWhere((c) => c.id == updatedCharacter.id);
    if (index != -1) {
      _characters[index] = updatedCharacter;
      _characters.refresh();
    }

    //  Update Favorites if exists
    final favController = Get.find<FavoritesController>();
    favController.updateFavorite(updatedCharacter);
  }
}

