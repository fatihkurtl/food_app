import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackBars {
  static void successSnackBar({required String message}) {
    Get.snackbar(
      'success'.tr,
      message.tr,
      backgroundColor: Colors.green[300],
      icon: const Icon(Icons.check),
      duration: const Duration(seconds: 3),
    );
  }

  static void errorSnackBar({required String message}) {
    Get.snackbar(
      'error'.tr,
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

  static void infoSnackBar({required String message}) {
    Get.snackbar(
      'informing'.tr,
      message.tr,
      backgroundColor: Colors.blue[300],
      icon: const Icon(Icons.info),
      duration: const Duration(seconds: 3),
    );
  }
}
