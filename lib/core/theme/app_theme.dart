import 'package:flutter/material.dart';

class AppTheme {}

ThemeData appThemeData = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.grey[300]!,
    primary: Colors.grey.shade900,
    secondary: Colors.grey[400]!,
  ),
  // appBarTheme: AppBarTheme(
  //   backgroundColor: Colors.grey[300],
  //   centerTitle: true,
  //   elevation: 0,
  //   titleTextStyle: TextStyle(
  //     color: Colors.black,
  //     fontSize: 24,
  //     fontWeight: FontWeight.bold,
  //     fontFamily: GoogleFonts.bebasNeue().fontFamily,
  //   ),
  //   iconTheme: IconThemeData(
  //     color: Colors.grey[600],
  //   ),
  // ),
);

ThemeData darkThemeData = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900,
    primary: Colors.grey[300]!,
    secondary: Colors.grey[700]!,
  ),
  // appBarTheme: AppBarTheme(
  //   backgroundColor: Colors.grey[900],
  //   centerTitle: true,
  //   elevation: 0,
  //   titleTextStyle: TextStyle(
  //     color: Colors.grey[300],
  //     fontSize: 24,
  //     fontWeight: FontWeight.bold,
  //     fontFamily: GoogleFonts.bebasNeue().fontFamily,
  //   ),
  //   iconTheme: IconThemeData(
  //     color: Colors.grey[300],
  //   ),
  // ),
);
