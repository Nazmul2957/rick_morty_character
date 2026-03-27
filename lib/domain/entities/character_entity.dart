// lib/domain/entities/character_entity.dart
class CharacterEntity {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String originName;
  final String locationName;
  final String image;

  CharacterEntity({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.originName,
    required this.locationName,
    required this.image,
  });

  // ADD THIS
  CharacterEntity copyWith({
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
    String? originName,
    String? locationName,
    String? image,
  }) {
    return CharacterEntity(
      id: id,
      name: name ?? this.name,
      status: status ?? this.status,
      species: species ?? this.species,
      type: type ?? this.type,
      gender: gender ?? this.gender,
      originName: originName ?? this.originName,
      locationName: locationName ?? this.locationName,
      image: image ?? this.image,
    );
  }
}