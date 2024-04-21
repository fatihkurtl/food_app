import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_app/view/home.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Food App",
      theme: ThemeData.light(),
      defaultTransition: Transition.native,
      home: const HomeView(),
    ),
  );
}
