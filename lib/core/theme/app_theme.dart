import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {}

final ThemeData appThemeData = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[300],
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontWeight: FontWeight.bold,
      fontFamily: GoogleFonts.bebasNeue().fontFamily,
    ),
    iconTheme: IconThemeData(
      color: Colors.grey[600],
    ),
  ),
  bottomAppBarTheme: BottomAppBarTheme(
    color: Colors.grey[300],
  ),
);
