import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rick_morty_character/routes/app_pages.dart';

import 'core/theme/app_theme.dart';
import 'data/models/character_hive_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(CharacterHiveModelAdapter());

  await Hive.openBox<CharacterHiveModel>('characters');
  await Hive.openBox<CharacterHiveModel>('favorites');
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {

      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Rick Morty App',

        // Theme management
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,

        // Initial route (SplashScreen will decide login/home)
        initialRoute: '/',
        getPages: AppPages.routes,
      );

  }
}
