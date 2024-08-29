import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static String get baseUrl => dotenv.env['BASE_URL'] ?? "http://10.0.2.2:8000/api/app";

  static const String carouselsRoute = "/carousel_photos";
  static const String popularRecipesRoute = "/popular_recipes";
  static const String recipesRoute = "/recipes";
  static const String categoriesRoute = "/categories";
  static const String recipesByCategoryRoute = "/category";
}
