// lib/domain/repositories/character_repository.dart
import '../entities/character_entity.dart';

abstract class CharacterRepository {
  Future<List<CharacterEntity>> getCharacters(int page);
}