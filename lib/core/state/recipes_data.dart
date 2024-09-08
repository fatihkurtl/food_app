import 'package:food_app/core/models/categories_models.dart';
import 'package:get/get.dart';
import 'package:food_app/core/models/customer_model.dart';
import 'package:food_app/core/models/recipes_models.dart';

class RecipeState extends GetxController {
  RxList<Recipe> recipes = RxList<Recipe>([]);
  RxList<Categories> categories = RxList<Categories>([]);
  Rx<Customer?> customerFavoriteRecipes = Rx<Customer?>(null);
  RxList<Recipe> popularRecipes = RxList<Recipe>([]);

  void setRecipes(List<Recipe> recipes) {
    this.recipes.value = recipes;
  }

  void setCategories(List<Categories> categories) {
    this.categories.value = categories;
  }
}
