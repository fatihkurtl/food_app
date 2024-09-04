import 'package:get/get.dart';
import 'package:food_app/core/models/customer_model.dart';
import 'package:food_app/core/models/recipes_models.dart';

class RecipeState extends GetxController {
  RxList<Recipe> recipes = RxList<Recipe>([]);
  RxList<Customer> customerFavoriteRecipes = RxList<Customer>([]);
  RxList<Recipe> popularRecipes = RxList<Recipe>([]);
}
