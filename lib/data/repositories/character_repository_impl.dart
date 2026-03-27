import 'package:hive/hive.dart';

import '../../domain/entities/character_entity.dart';
import '../../domain/repositories/character_repository.dart';
import '../datasources/remote/character_list_data_source.dart';
import '../models/character_hive_model.dart';
import '../models/character_model.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterListDataSource remoteDataSource;
  final Box<CharacterHiveModel> box;

  CharacterRepositoryImpl({required this.remoteDataSource, required this.box});

  static const int pageSize = 20;

  // Lock to prevent multiple API calls
  bool isFetching = false;

  //  Background fetch method (controlled pagination)
  Future<void> _fetchAndCacheAllData() async {
    //  Prevent multiple calls
    if (isFetching) return;

    isFetching = true;

    int currentPage = 1;

    while (true) {
      try {
        final result = await remoteDataSource.getCharacters(currentPage);

        // Stop when API returns empty
        if (result.isEmpty) break;

        // Save into Hive
        for (var item in result) {
          box.put(item.id, CharacterHiveModel.fromEntity(item));
        }

        currentPage++;

        // Add delay to prevent server overload
        await Future.delayed(const Duration(milliseconds: 500));
      } catch (e) {
        print("Pagination error: $e");
        break;
      }
    }

    isFetching = false;
  }

  @override
  Future<List<CharacterEntity>> getCharacters(int page) async {
    // Only trigger background API once
    if (box.isEmpty) {
      _fetchAndCacheAllData(); //  DON'T await → run in background
    }

    // STEP: Load from Hive
    final allData = box.values.map((e) => e.toEntity()).toList();

    // STEP: Local pagination
    final startIndex = (page - 1) * pageSize;
    final endIndex = startIndex + pageSize;

    if (startIndex >= allData.length) {
      return [];
    }

    return allData.sublist(
      startIndex,
      endIndex > allData.length ? allData.length : endIndex,
    );
  }
}
