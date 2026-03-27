import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/snackbar_constants.dart';

class SnackbarService {
  // Singleton
  static SnackbarService instance = SnackbarService._internal();
  SnackbarService._internal();
  factory SnackbarService() => instance;

  void showSuccess(String message, {String title = "Success"}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackbarConstants.position,
      backgroundColor: SnackbarConstants.success,
      colorText: Colors.white,
      margin: SnackbarConstants.margin,
      borderRadius: SnackbarConstants.borderRadius,
      duration: SnackbarConstants.duration,
    );
  }

  void showError(String message, {String title = "Error"}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackbarConstants.position,
      backgroundColor: SnackbarConstants.error,
      colorText: Colors.white,
      margin: SnackbarConstants.margin,
      borderRadius: SnackbarConstants.borderRadius,
      duration: SnackbarConstants.duration,
    );
  }

  void showInfo(String message, {String title = "Info"}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackbarConstants.position,
      backgroundColor: SnackbarConstants.info,
      colorText: Colors.white,
      margin: SnackbarConstants.margin,
      borderRadius: SnackbarConstants.borderRadius,
      duration: SnackbarConstants.duration,
    );
  }
}