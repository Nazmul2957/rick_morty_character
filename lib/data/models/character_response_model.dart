import 'character_model.dart';

class CharacterResponseModel {
  final int count;
  final int pages;
  final String? next;
  final String? prev;
  final List<CharacterModel> results;

  CharacterResponseModel({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev,
    required this.results,
  });

  factory CharacterResponseModel.fromJson(Map<String, dynamic> json) {
    return CharacterResponseModel(
      count: json['info']['count'],
      pages: json['info']['pages'],
      next: json['info']['next'],
      prev: json['info']['prev'],
      results: (json['results'] as List)
          .map((e) => CharacterModel.fromJson(e))
          .toList(),
    );
  }
}