import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../../../domain/entities/character_entity.dart';
import 'edit_screen.dart';

class CharacterDetailScreen extends StatelessWidget {
  final CharacterEntity character;

  const CharacterDetailScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Get.to(() => EditCharacterScreen(character: character));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Character Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child:CachedNetworkImage(
                imageUrl: character.image,
                width: double.infinity,
                height: 200,
                fit: BoxFit.fill,

                placeholder: (context, url) => const SizedBox(
                  width: 80,
                  height: 80,
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  ),
                ),

                errorWidget: (context, url, error) =>
                const Icon(Icons.person, size: 80),
              ),

            ),
            const SizedBox(height: 16),

            // Character Info
            Text(
              character.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            infoRow("Status", character.status),
            infoRow("Species", character.species),
            infoRow("Type", character.type.isEmpty ? "-" : character.type),
            infoRow("Gender", character.gender),
            infoRow("Origin", character.originName),
            infoRow("Location", character.locationName),
          ],
        ),
      ),
    );
  }

  // Helper method to show info
  Widget infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            "$title: ",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
