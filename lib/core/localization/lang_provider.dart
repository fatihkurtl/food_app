import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> toggleLanguage(Locale languageCode) async {
  // print('languageCode $languageCode');
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('languageCode', languageCode.toString());
}
