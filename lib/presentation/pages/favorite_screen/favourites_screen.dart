import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/favourites/favourites_controller.dart';
import '../character_screen/character_details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({super.key});

  final FavoritesController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),
      body: Obx(() {
        if (controller.favorites.isEmpty) {
          return const Center(child: Text("No favorites yet"));
        }

        return ListView.builder(
          itemCount: controller.favorites.length,
          itemBuilder: (context, index) {
            final character = controller.favorites[index];

            return GestureDetector(
              onTap: () {
                Get.to(
                  () => CharacterDetailScreen(character: character.toEntity()),
                );
              },
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      character.image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.person),
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name: ${character.name}"),
                      Text("Status: ${character.status}"),
                      Text("Species: ${character.species}"),
                      Text("Type: ${character.type}"),
                      Text("Gender: ${character.gender}"),
                    ],
                  ),

                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      controller.removeFavorite(character.id);
                    },
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
