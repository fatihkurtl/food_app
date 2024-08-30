import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:food_app/core/navigation/routes.dart';
import 'package:food_app/utils/constants.dart';
import 'package:food_app/core/services/api.dart';
import 'package:food_app/core/components/snackbars.dart';

class CustomerAuthHelper {
  static Future<Map<String, dynamic>> customerRegister(Map<String, dynamic> body) async {
    final response = await ApiServices.post(Constants.customerRegisterRoute, body);
    try {
      if (response['statusCode'] == 200) {
        SnackBars.successSnackBar(message: response['body']['message']);
        Get.offNamed(Routes.signIn);
        return {
          "statusCode": response['statusCode'],
          "body": response['body'],
        };
      } else {
        if (response['statusCode'] == 404 && response['body']['status'] == 'error') {
          SnackBars.errorSnackBar(message: response['body']['message']);
        }
        return {
          "statusCode": response['statusCode'],
          "body": response['body'],
        };
      }
    } catch (e) {
      SnackBars.errorSnackBar(
        message: response['body']['message'],
      );
    }
    SnackBars.errorSnackBar(message: response['body']['message']);
    return {};
  }

  static Future<Map<String, dynamic>> customerLogin(Map<String, dynamic> body, BuildContext context) async {
    final response = await ApiServices.post(Constants.customerLoginRoute, body);
    try {
      print(response);
      if (response['statusCode'] == 200) {
        SnackBars.successSnackBar(message: response['body']['message']);
        Navigator.pushNamed(context, Routes.home);
        await _saveLoginData(response['body']);
        return {
          "statusCode": response['statusCode'],
          "body": response['body'],
        };
      } else {
        if (response['statusCode'] == 404 && response['body']['status'] == 'error') {
          SnackBars.errorSnackBar(message: response['body']['message']);
        }
        return {
          "statusCode": response['statusCode'],
          "body": response['body'],
        };
      }
    } catch (e) {
      SnackBars.errorSnackBar(
        message: response['body']['message'],
      );
    }
    SnackBars.errorSnackBar(message: response['body']['message']);
    return {};
  }

  static Future<void> _saveLoginData(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('access_token', data['access_token']);
    await prefs.setInt('userId', data['customer']['id']);
  }
}
