import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../../core/constants/app_routes.dart';
import '../../../domain/entities/character_entity.dart';
import '../../controllers/character_list/character_controller.dart';

class EditCharacterScreen extends StatelessWidget {
  final CharacterEntity character;

  EditCharacterScreen({super.key, required this.character});

  final nameController = TextEditingController();
  final statusController = TextEditingController();
  final speciesController = TextEditingController();
  final genderController = TextEditingController();
  final typeController = TextEditingController();
  final originController = TextEditingController();
  final locationController = TextEditingController();

  final CharacterController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    // Set initial values
    nameController.text = character.name;
    statusController.text = character.status;
    speciesController.text = character.species;
    genderController.text = character.gender;
    typeController.text = character.type;
    originController.text = character.originName;
    locationController.text = character.locationName;

    return Scaffold(
      appBar: AppBar(title: const Text("Edit Character")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: statusController,
              decoration: const InputDecoration(labelText: "Status"),
            ),
            TextField(
              controller: speciesController,
              decoration: const InputDecoration(labelText: "Species"),
            ),
            TextField(
              controller: genderController,
              decoration: const InputDecoration(labelText: "Gender"),
            ),
            TextField(
              controller: typeController,
              decoration: const InputDecoration(labelText: "Type"),
            ),
            TextField(
              controller: originController,
              decoration: const InputDecoration(labelText: "Origin"),
            ),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(labelText: "Location"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                final updated = character.copyWith(
                  name: nameController.text,
                  status: statusController.text,
                  species: speciesController.text,
                  gender: genderController.text,
                  type: typeController.text,
                  originName: originController.text,
                  locationName: locationController.text,
                );

                controller.updateCharacter(updated);
                Get.offAllNamed(AppRoutes.home);
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
