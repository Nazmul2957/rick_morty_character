import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/character_hive_model.dart';
import '../../controllers/character_list/character_controller.dart';
import '../../controllers/favourites/favourites_controller.dart';
import 'character_details_screen.dart';

class CharacterScreen extends StatelessWidget {
  CharacterScreen({super.key});

  final CharacterController controller = Get.find();
  final FavoritesController favController = Get.find();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // Infinite scroll listener
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          controller.hasMore.value) {
        controller.loadMore();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Characters"),
        actions: [
          IconButton(
            icon: Icon(Get.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              Get.changeTheme(
                Get.isDarkMode ? ThemeData.light() : ThemeData.dark(),
              );
            },
          ),
        ],
      ),
      body: Obx(() {
        // Initial loading
        if (controller.isLoading.value && controller.characters.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        // Empty state
        if (controller.characters.isEmpty && !controller.isLoading.value) {
          return const Center(
            child: Text(
              "No characters found",
              style: TextStyle(color: Colors.red),
            ),
          );
        }

        return ListView.builder(
          controller: scrollController,
          itemCount: controller.characters.length + 1,
          itemBuilder: (context, index) {
            // Pagination loading indicator
            if (index == controller.characters.length) {
              return controller.hasMore.value
                  ? const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : const SizedBox.shrink();
            }

            final character = controller.characters[index];

            return GestureDetector(
              onTap: () {
                Get.to(() => CharacterDetailScreen(character: character));
              },
              child: Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Character image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: character.image,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,

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
                      const SizedBox(width: 12),

                      // Character details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              character.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${character.species} - ${character.gender}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "Status: ${character.status}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "Location: ${character.locationName}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),

                      // Favorite button
                      SizedBox(
                        width:50,
                        // height: 20,
                        child: Obx(() {
                          final isFav = favController.favorites.any(
                            (c) => c.id == character.id,
                          ); // check observable list
                          return IconButton(
                            icon: Icon(
                              isFav ? Icons.favorite : Icons.favorite_border,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              final hiveModel = CharacterHiveModel.fromEntity(
                                character,
                              );
                              if (isFav) {
                                favController.removeFavorite(character.id);
                              } else {
                                favController.addFavorite(hiveModel);
                              }
                            },
                          );
                        }),
                      ),
                    ],
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
