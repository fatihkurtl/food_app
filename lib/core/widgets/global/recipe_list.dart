import 'package:flutter/material.dart';
import 'package:food_app/core/models/customer_model.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food_app/core/components/loading.dart';
import 'package:food_app/view/recipe_detail.dart';
import 'package:food_app/core/helpers/recipes.dart';
import 'package:food_app/core/models/recipes_models.dart';

class RecipeList extends StatefulWidget {
  final List<Recipe> recipes;
  final Rx<Customer?> customerFavoriteRecipes;
  final int? selectedCategoryId;
  final bool Function(int) isRecipeFavorited;
  final void Function(int)? handleSaveRecipe;
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
  _RecipeListState createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  late List<bool> _favoriteStates;

  @override
  void initState() {
    super.initState();
    _favoriteStates = widget.recipes.map((recipe) => widget.isRecipeFavorited(recipe.id)).toList();
  }

  @override
  void didUpdateWidget(covariant RecipeList oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Eğer tarif listesi veya müşteri favori tarifler değişirse favori durumlarını güncelle
    if (oldWidget.recipes != widget.recipes || oldWidget.customerFavoriteRecipes != widget.customerFavoriteRecipes) {
      setState(() {
        _favoriteStates = widget.recipes.map((recipe) => widget.isRecipeFavorited(recipe.id)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: widget.recipes.length,
      itemBuilder: (context, index) {
        final recipe = widget.recipes[index];
        // bool isFavorite = widget.isRecipeFavorited(recipe.id);
        return GestureDetector(
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
                  likesCount: recipe.likesCount,
                  commentCount: 6,
                  recipeContent: recipe.content,
                  recipeContentEn: recipe.contentEn,
                ),
              ),
            );
          },
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                      child: Image.network(
                        "http://10.0.2.2:8000/storage/${recipe.image}",
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1) : null,
                            ),
                          );
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
                    Positioned(
                      top: 5,
                      right: 5,
                      child: CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.7),
                        child: IconButton(
                          icon: Icon(
                            _favoriteStates[index] ? Icons.favorite : Icons.favorite_border,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              _favoriteStates[index] = !_favoriteStates[index];
                            });
                            if (_favoriteStates[index]) {
                              widget.handleSaveRecipe!(recipe.id);
                            } else {
                              widget.removeRecipe(recipe.id);
                            }
                            if (kDebugMode) {
                              print('Pressed Bookmark');
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          Get.locale?.languageCode == "tr" ? recipe.name : recipe.nameEn,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Icon(Icons.timer, size: 16, color: Colors.grey[600]),
                            const SizedBox(width: 4),
                            Text(
                              '4 min',
                              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.local_fire_department,
                                  size: 16,
                                  color: Colors.orange,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '444 cal',
                                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                ),
                              ],
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.share,
                                size: 20,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                RecipesHelper.shareRecipe(recipe.name);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
