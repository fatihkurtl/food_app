import 'package:flutter/material.dart';
import 'package:food_app/core/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = appThemeData;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme(bool isDarkMode) {
    if (isDarkMode) {
      themeData = darkThemeData;
    } else {
      themeData = appThemeData;
    }
    saveTheme(isDarkMode);
    notifyListeners();
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('isDarkMode');
    if (isDarkMode != null) {
      _themeData = isDarkMode ? darkThemeData : appThemeData;
      notifyListeners();
    }
  }

  Future<void> saveTheme(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDarkMode);
  }
}
