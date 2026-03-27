// lib/domain/usecases/get_characters.dart

import '../repositories/character_repository.dart';
import '../entities/character_entity.dart';

class GetCharacters {
  final CharacterRepository repository;

  GetCharacters(this.repository);

  Future<List<CharacterEntity>> call(int page) async {
    return await repository.getCharacters(page);
  }
}
