// lib/data/models/character_model.dart

import '../../domain/entities/character_entity.dart';

class CharacterModel extends CharacterEntity {
  CharacterModel({
    required super.id,
    required super.name,
    required super.status,
    required super.species,
    required super.type,
    required super.gender,
    required super.originName,
    required super.locationName,
    required super.image,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'],
      name: json['name'] ?? '',
      status: json['status'] ?? '',
      species: json['species'] ?? '',
      type: json['type'] ?? '',
      gender: json['gender'] ?? '',
      originName: json['origin']?['name'] ?? '',
      locationName: json['location']?['name'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "status": status,
      "species": species,
      "type": type,
      "gender": gender,
      "origin": {"name": originName},
      "location": {"name": locationName},
      "image": image,
    };
  }

  CharacterModel copyWith({
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
    String? originName,
    String? locationName,
    String? image,
  }) {
    return CharacterModel(
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
