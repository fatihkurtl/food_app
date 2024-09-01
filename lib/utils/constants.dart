import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static String get baseUrl => dotenv.env['BASE_URL'] ?? "http://10.0.2.2:8000/api/app";

  static const String carouselsRoute = "/carousel_photos";
  static const String popularRecipesRoute = "/popular_recipes";
  static const String recipesRoute = "/recipes";
  static const String categoriesRoute = "/categories";
  static const String saveRecipeRoute = "/save/recipe";
  static const String recipesByCategoryRoute = "/category";
  static const String customerRegisterRoute = "/customer/register";
  static const String customerLoginRoute = "/customer/login";
  static const String customerLogoutRoute = "/customer/logout";
  static const String customerProfileRoute = "/customer";
  static const String removeFavoriteRecipeRoute = "/customer/remove-favorite-recipe";
}
