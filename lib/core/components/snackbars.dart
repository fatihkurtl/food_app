import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackBars {
  static void successSnackBar({required String message}) {
    Get.snackbar(
      'Basarılı',
      message,
      backgroundColor: Colors.green[300],
      icon: const Icon(Icons.check),
      duration: const Duration(seconds: 3),
    );
  }

  static void errorSnackBar({required String message}) {
    Get.snackbar(
      'Hata',
      message,
      backgroundColor: Colors.red[300],
      icon: const Icon(Icons.error),
      duration: const Duration(seconds: 3),
    );
  }

  static void warningSnackBar({required String message}) {
    Get.snackbar(
      'Uyarı',
      message,
      backgroundColor: Colors.orange[300],
      icon: const Icon(Icons.warning),
      duration: const Duration(seconds: 3),
    );
  }
}
