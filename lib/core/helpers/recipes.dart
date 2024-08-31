import 'package:food_app/core/components/snackbars.dart';
import 'package:food_app/core/middlewares/check_auth.dart';
import 'package:food_app/utils/constants.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:food_app/core/models/carousel_models.dart';
import 'package:share_plus/share_plus.dart';
import 'package:food_app/core/services/api.dart';
import 'package:food_app/core/models/recipes_models.dart';
import 'package:food_app/core/models/categories_models.dart';

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class RecipesHelper {
  static var carousels = <Carousel>[].obs;
  static var popularRecipes = <Recipe>[].obs;
  static var recipes = <Recipe>[].obs;
  static var categories = <Categories>[].obs;

  static Future<List<Carousel>> getAllCarousels() async {
    final response = await ApiServices.get(Constants.carouselsRoute);
    if (response['statusCode'] == 200) {
      final List<dynamic> data = json.decode(response['body']);
      carousels.value = data.map((json) => Carousel.fromJson(json)).toList();
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

  static Future<List<Recipe>> getRecipesByCategory(int categoryId) async {
    final response = await ApiServices.get('${Constants.recipesByCategoryRoute}/$categoryId');
    if (response['statusCode'] == 200) {
      final List<dynamic> data = json.decode(response['body']);
      recipes.value = data.map((json) => Recipe.fromJson(json)).toList();
    } else {
      recipes.value = [];
    }
    return recipes;
  }

  static Future<List<Categories>> getAllCategories() async {
    final response = await ApiServices.get(Constants.categoriesRoute);
    if (response['statusCode'] == 200) {
      final List<dynamic> data = json.decode(response['body']);
      categories.value = data.map((json) => Categories.fromJson(json)).toList();
    } else {
      categories.value = [];
    }
    return categories;
  }

  static void saveRecipe(int recipeId) async {
    print('Recipe ID: $recipeId');
    final data = await CheckCustomerAuth.checkCustomer();
    final prefs = await SharedPreferences.getInstance();

    var token = prefs.getString('access_token');
    var customerId = prefs.getInt('customerId');
    var isLoggedIn = prefs.getBool('isLoggedIn');
    print('token: $token');
    if (isLoggedIn == null || token == null || customerId == null) {
      SnackBars.infoSnackBar(message: 'you_must_be_logged_in_to_save_recipes');
    } else {
      if (customerId == data['customerId'] && token == data['token']) {
        final response = await ApiServices.post(Constants.saveRecipeRoute, {'recipeId': recipeId, 'customerId': customerId});
        if (response['statusCode'] == 200) {
          SnackBars.successSnackBar(message: 'recipe_saved_successfully');
        } else {
          SnackBars.infoSnackBar(message: 'you_must_be_logged_in_to_save_recipes');
        }
      } else {
        SnackBars.infoSnackBar(message: 'you_must_be_logged_in_to_save_recipes');
      }
    }
  }

  static void shareRecipe(String recipeUrl) {
    if (kDebugMode) {
      print('Shared Recipe: $recipeUrl');
    }
    Share.share('Check out this recipe: $recipeUrl');
  }
}
