import 'package:flutter/material.dart';
import 'package:food_app/core/components/bottom-navigation.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Food App",
      theme: ThemeData.light(),
      defaultTransition: Transition.native,
      home: const CustomBottomNavigation(),
    ),
  );
}
