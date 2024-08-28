import 'package:food_app/utils/constants.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:food_app/core/models/carousel_models.dart';
import 'package:share_plus/share_plus.dart';
import 'package:food_app/core/services/api.dart';
import 'package:food_app/core/models/recipes_models.dart';

import 'dart:convert';

class Helper {
  static var carousels = <Carousel>[].obs;
  static var popularRecipes = <Recipe>[].obs;
  static var recipes = <Recipe>[].obs;

  static Future<List<Carousel>> getAllCarousels() async {
    final response = await ApiServices.get(Constants.carouselsRoute);
    if (response['statusCode'] == 200) {
      final List<dynamic> data = json.decode(response['body']);
      carousels.value = data.map((json) => Carousel.fromJson(json)).toList();
      print(carousels.length);
    } else {
      carousels.value = [];
    }
    return carousels;
  }

  static Future<List<Recipe>> getPopularRecipes() async {
    final response = await ApiServices.get(Constants.popularRecipesRoute);
    if (response['statusCode'] == 200) {
      final List<dynamic> data = json.decode(response['body']);
      popularRecipes.value = data.map((json) => Recipe.fromJson(json)).toList();
    } else {
      popularRecipes.value = [];
    }
    return popularRecipes;
  }

  static Future<List<Recipe>> getAllRecipes() async {
    final response = await ApiServices.get(Constants.recipesRoute);
    if (response['statusCode'] == 200) {
      final List<dynamic> data = json.decode(response['body']);
      recipes.value = data.map((json) => Recipe.fromJson(json)).toList();
    } else {
      recipes.value = [];
    }
    return recipes;
  }

  static void shareRecipe(String recipeUrl) {
    if (kDebugMode) {
      print('Shared Recipe: $recipeUrl');
    }
    Share.share('Check out this recipe: $recipeUrl');
  }
}
