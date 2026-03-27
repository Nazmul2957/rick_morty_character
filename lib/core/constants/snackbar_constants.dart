// lib/core/constants/snackbar_constants.dart
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

class SnackbarConstants {
  static const Duration duration = Duration(seconds: 3);
  static const SnackPosition position = SnackPosition.BOTTOM;
  static const double borderRadius = 8;
  static const EdgeInsets margin = EdgeInsets.all(12);

  static const Color success = Colors.green;
  static const Color error = Colors.red;
  static const Color info = Colors.blue;
}