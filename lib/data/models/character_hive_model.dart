import 'package:hive/hive.dart';

import '../../domain/entities/character_entity.dart';
part 'character_hive_model.g.dart';

@HiveType(typeId: 0)
class CharacterHiveModel extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String status;

  @HiveField(3)
  String species;

  @HiveField(4)
  String type;

  @HiveField(5)
  String gender;

  @HiveField(6)
  String originName;

  @HiveField(7)
  String locationName;

  @HiveField(8)
  String image;

  CharacterHiveModel({
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

  factory CharacterHiveModel.fromEntity(CharacterEntity e) {
    return CharacterHiveModel(
      id: e.id,
      name: e.name,
      status: e.status,
      species: e.species,
      type: e.type,
      gender: e.gender,
      originName: e.originName,
      locationName: e.locationName,
      image: e.image,
    );
  }

  CharacterEntity toEntity() {
    return CharacterEntity(
      id: id,
      name: name,
      status: status,
      species: species,
      type: type,
      gender: gender,
      originName: originName,
      locationName: locationName,
      image: image,
    );
  }
}
