import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_app/core/theme/app_theme.dart';
import 'package:food_app/core/components/bottom_navigation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Food App",
      theme: appThemeData,
      defaultTransition: Transition.native,
      home: const CustomBottomNavigation(),
    ),
  );
}
