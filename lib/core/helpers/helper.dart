import 'package:flutter/foundation.dart';
import 'package:share_plus/share_plus.dart';
import 'package:food_app/core/services/api.dart';
import 'package:food_app/core/models/recipes_models.dart';

import 'dart:convert';

class Helper {
  static List<Recipe> recipes = [];
  static String recipesRoute = '/recipes';

  static void shareRecipe(String recipeUrl) {
    if (kDebugMode) {
      print('Shared Recipe: $recipeUrl');
    }
    Share.share('Check out this recipe: $recipeUrl');
  }

  static Future<List<Recipe>> getAllRecipes() async {
    final response = await ApiServices.get(recipesRoute);
    if (response['statusCode'] == 200) {
      final List<dynamic> data = json.decode(response['body']);
      recipes = data.map((json) => Recipe.fromJson(json)).toList();
    } else {
      // Handle error
      recipes = [];
    }
    return recipes;
  }
}
