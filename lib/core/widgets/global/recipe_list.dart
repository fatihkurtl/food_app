import 'package:flutter/material.dart';
import 'package:food_app/core/models/customer_model.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food_app/core/components/loading.dart';
import 'package:food_app/view/recipe_detail.dart';
import 'package:food_app/core/helpers/recipes.dart';
import 'package:food_app/core/models/recipes_models.dart';

class RecipeList extends StatelessWidget {
  final List<Recipe> recipes;
  final Rx<Customer?> customerFavoriteRecipes;
  final int selectedCategoryId;
  final bool Function(int) isRecipeFavorited;
  final void Function(int) handleSaveRecipe;
  final void Function(int) removeRecipe;

  const RecipeList({
    super.key,
    required this.recipes,
    required this.customerFavoriteRecipes,
    required this.selectedCategoryId,
    required this.isRecipeFavorited,
    required this.handleSaveRecipe,
    required this.removeRecipe,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.9,
        ),
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          final isFavorite = isRecipeFavorited(recipe.id);
          return InkWell(
            onTap: () {
              if (kDebugMode) {
                print('Tapped Recipe: ${recipe.name}');
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeDetailView(
                    recipeId: recipe.id,
                    foodName: recipe.name,
                    foodNameEn: recipe.nameEn,
                    imageUrl: "http://10.0.2.2:8000/storage/${recipe.image}",
                    recipeContent: recipe.content,
                    recipeContentEn: recipe.contentEn,
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: Image.network(
                        "http://10.0.2.2:8000/storage/${recipe.image}",
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1) : null,
                              ),
                            );
                          }
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: CustomLoading(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: IconButton(
                            icon: Icon(
                              isFavorite ? Icons.bookmark : Icons.bookmark_border,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            tooltip: "save".tr,
                            onPressed: () {
                              final isFavorite = isRecipeFavorited(recipe.id);
                              if (isFavorite) {
                                removeRecipe(recipe.id);
                              } else {
                                handleSaveRecipe(recipe.id);
                              }
                              if (kDebugMode) {
                                print('Pressed Bookmark');
                              }
                            },
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              Get.locale?.languageCode == "tr" ? recipe.name : recipe.nameEn,
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                                textStyle: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: IconButton(
                            icon: Icon(
                              Icons.share,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            tooltip: "share".tr,
                            onPressed: () {
                              RecipesHelper.shareRecipe(recipe.name);
                              if (kDebugMode) {
                                print('Pressed Share');
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
