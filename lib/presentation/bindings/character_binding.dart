// lib/presentation/bindings/character_binding.dart
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../../data/datasources/remote/character_list_data_source.dart';
import '../../core/network/api_client.dart';
import 'package:http/http.dart' as http;
import '../../data/models/character_hive_model.dart';
import '../../data/repositories/character_repository_impl.dart';
import '../../domain/repositories/character_repository.dart';
import '../../domain/usecases/get_characters.dart';
import '../controllers/character_list/character_controller.dart';
import '../controllers/favourites/favourites_controller.dart';


class CharacterBinding extends Bindings {
  @override
  void dependencies() {
    // http client
    Get.lazyPut<http.Client>(() => http.Client());

    // ApiClient
    Get.lazyPut<ApiClient>(
          () => ApiClient(client: Get.find()),
    );

    // DataSource
    Get.lazyPut<CharacterListDataSource>(
          () => CharacterListDataSourceImpl(Get.find<ApiClient>()),
    );

    // Hive Box
    Get.lazyPut<Box<CharacterHiveModel>>(
          () => Hive.box<CharacterHiveModel>('characters'),
    );

    // Repository (FIXED)
    Get.lazyPut<CharacterRepository>(
          () => CharacterRepositoryImpl(
        remoteDataSource: Get.find(),
        box: Get.find(),
      ),
    );

    //  UseCase
    Get.lazyPut<GetCharacters>(
          () => GetCharacters(Get.find()),
    );

    // FavoritesController
    Get.lazyPut<FavoritesController>(() => FavoritesController());

    // Controller
    Get.lazyPut<CharacterController>(
          () => CharacterController(Get.find()),
    );
  }
}