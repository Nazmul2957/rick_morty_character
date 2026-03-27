// lib/presentation/routes/app_pages.dart
import 'package:get/get.dart';
import 'package:rick_morty_character/core/constants/app_routes.dart';
import '../presentation/bindings/character_binding.dart';

import '../presentation/pages/character_screen/character_list_screen.dart';

import '../presentation/pages/home/home_screen.dart';
import '../presentation/pages/splash_screen/splash_screen.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.initial,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => MainScreen(),
      binding: CharacterBinding(),
    ),
    //
    GetPage(
      name: AppRoutes.character,
      page: () => CharacterScreen(),
      binding: CharacterBinding(),
    ),
  ];
}
