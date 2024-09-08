import 'package:flutter/material.dart';
import 'package:food_app/core/services/api.dart';
import 'package:food_app/utils/constants.dart';
import 'package:get/get.dart';
import 'package:food_app/core/helpers/customers_auth.dart';
import 'package:food_app/core/middlewares/check_auth.dart';
import 'package:food_app/core/models/customer_model.dart';
import 'package:food_app/core/widgets/global/recipe_list.dart';
import 'package:food_app/core/components/snackbars.dart';
import 'package:food_app/core/models/categories_models.dart';
import 'package:food_app/core/widgets/recipes/category_button.dart';
import 'package:food_app/core/components/loading.dart';
import 'package:food_app/core/helpers/recipes.dart';
import 'package:food_app/core/models/recipes_models.dart';

class RecipesView extends StatefulWidget {
  const RecipesView({super.key});

  @override
  _RecipesViewState createState() => _RecipesViewState();
}

class _RecipesViewState extends State<RecipesView> {
  final recipes = <Recipe>[].obs;
  final customerFavoriteRecipes = Rx<Customer?>(null);
  final categories = <Categories>[].obs;
  final selectedCategoryId = 0.obs;
  final previouslySelectedCategoryId = 0.obs;
  final isLoggedIn = false.obs;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    if (selectedCategoryId.value == 0) {
      await fetchRecipes();
    } else {
      await fetchRecipesByCategory(selectedCategoryId.value);
    }
    await fetchCustomerRecipes();
    await fetchCategories();
  }

  Future<void> fetchRecipes() async {
    try {
      await RecipesHelper.getAllRecipes();
      recipes.value = RecipesHelper.recipes;
    } catch (e) {
      SnackBars.errorSnackBar(message: 'Error fetching recipes: $e');
    }
  }

  Future<void> fetchCustomerRecipes() async {
    try {
      final data = await CheckCustomerAuth.checkCustomer();
      final profileData = await CustomerAuthHelper.getCustomerProfile(data['token'], data['customerId']);
      customerFavoriteRecipes.value = profileData['body'] as Customer;
    } catch (e) {
      SnackBars.errorSnackBar(message: e.toString());
    }
  }

  Future<void> fetchRecipesByCategory(int categoryId) async {
    try {
      await RecipesHelper.getRecipesByCategory(categoryId);
      recipes.value = RecipesHelper.recipes;
    } catch (e) {
      SnackBars.errorSnackBar(message: e.toString());
    }
  }

  Future<void> fetchCategories() async {
    try {
      await RecipesHelper.getAllCategories();
      categories.value = RecipesHelper.categories;
    } catch (e) {
      SnackBars.errorSnackBar(message: e.toString());
    }
  }

  void onCategorySelected(int categoryId) {
    if (categoryId == selectedCategoryId.value) {
      selectedCategoryId.value = 0;
      fetchRecipes();
    } else {
      previouslySelectedCategoryId.value = selectedCategoryId.value;
      selectedCategoryId.value = categoryId;
      fetchRecipesByCategory(categoryId);
    }
  }

  void handleSaveRecipe(int recipeId) async {
    RecipesHelper.saveRecipe(recipeId);
    await fetchCustomerRecipes();
  }

  bool isRecipeFavorited(int? recipeId) {
    final favoriteRecipes = customerFavoriteRecipes.value?.favoriteRecipes;
    return favoriteRecipes?.any((recipe) => recipe.id == recipeId) ?? false;
  }

  void removeRecipe(int id) async {
    final data = await CheckCustomerAuth.checkCustomer();
    final response = await ApiServices.put(Constants.removeFavoriteRecipeRoute, data['token'], {"recipe_id": id});

    if (response['statusCode'] == 200) {
      SnackBars.successSnackBar(message: 'recipe_removed_successfully');
      await fetchCustomerRecipes();
    } else {
      SnackBars.infoSnackBar(message: 'you_must_be_logged_in_to_remove_recipes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (recipes.isEmpty && categories.isEmpty) {
        return Center(
          child: CustomLoading(
            color: Theme.of(context).colorScheme.secondary,
          ),
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "search_recipes".tr,
                  hintStyle: TextStyle(
                    color: Colors.grey[600],
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 10.0,
              children: categories
                  .map(
                    (category) => CategoryButton(
                      categoryId: category.id,
                      selectedCategoryId: selectedCategoryId.value,
                      text: category.name,
                      textEn: category.nameEn,
                      onSelect: onCategorySelected,
                    ),
                  )
                  .toList(),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: RecipeList(
                  recipes: recipes,
                  customerFavoriteRecipes: customerFavoriteRecipes,
                  selectedCategoryId: selectedCategoryId.value,
                  handleSaveRecipe: handleSaveRecipe,
                  isRecipeFavorited: isRecipeFavorited,
                  removeRecipe: removeRecipe,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
