// lib/presentation/screens/splash_screen.dart
// lib/presentation/screens/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:rick_morty_character/core/constants/app_routes.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate to HomeScreen after 2 seconds
    Timer(const Duration(seconds: 2), () {
      Get.offNamed(AppRoutes.home);
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Rick & Morty Characters",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20),

            // Loader
            // CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
