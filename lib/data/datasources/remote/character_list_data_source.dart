// lib/data/datasources/remote/character_list_data_source.dart

import '../../../core/errors/exception.dart';
import '../../../core/network/api_client.dart';
import '../../models/character_model.dart';

abstract class CharacterListDataSource {
  Future<List<CharacterModel>> getCharacters(int page);
}

class CharacterListDataSourceImpl implements CharacterListDataSource {
  final ApiClient apiClient;

  CharacterListDataSourceImpl(this.apiClient);

  @override
  Future<List<CharacterModel>> getCharacters(int page, {int retry = 0}) async {
    const maxRetries = 5;
    try {
      final response = await apiClient.get(
        "character",
        queryParameters: {"page": page.toString()},
      );

      if (response['results'] != null) {
        final List<dynamic> results = response['results'];
        return results.map((json) => CharacterModel.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      if (e is ServerException &&
          e.message.contains('826') &&
          retry < maxRetries) {
        final waitSeconds = 5 * (retry + 1);
        await Future.delayed(Duration(seconds: waitSeconds));
        return getCharacters(page, retry: retry + 1);
      }
      print("Error fetching page $page: $e");
      return [];
    }
  }
}
