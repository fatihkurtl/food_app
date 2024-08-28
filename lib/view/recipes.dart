import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food_app/core/widgets/recipes/category_button.dart';
import 'package:food_app/core/components/loading.dart';
import 'package:food_app/view/recipe_detail.dart';
import 'package:food_app/core/helpers/helper.dart';
import 'package:food_app/core/models/recipes_models.dart';

// import 'package:food_app/core/components/appbar.dart';
// import 'package:food_app/core/components/bottom-navigation.dart';
// import 'package:food_app/core/components/drawer.dart';

class RecipesView extends StatefulWidget {
  const RecipesView({super.key});

  @override
  _RecipesViewState createState() => _RecipesViewState();
}

class _RecipesViewState extends State<RecipesView> {
  var recipes = <Recipe>[].obs;

  @override
  void initState() {
    super.initState();
    fetchRecipes();
  }

  Future<void> fetchRecipes() async {
    try {
      await Helper.getAllRecipes();
      setState(() {
        recipes.value = Helper.recipes;
      });
    } catch (e) {
      print('Error fetching recipes: $e');
      SnackBar(content: Text('Error fetching recipes: $e'));
    }
  }

  @override
  Widget build(BuildContext context) {
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
            child: Padding(
              padding: const EdgeInsets.only(left: 0.0),
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
        ),
        const SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Wrap(
            spacing: 10.0,
            children: [
              CategoryButton(text: "main_meals"),
              CategoryButton(text: "soups"),
              CategoryButton(text: "salads"),
              CategoryButton(text: "breakfast_foods"),
              CategoryButton(text: "desserts"),
              CategoryButton(text: "drinks"),
              CategoryButton(text: "vegan_vegetarian"),
              CategoryButton(text: "pastas"),
              CategoryButton(text: "world_cuisines"),
              CategoryButton(text: "healthy_recipes"),
            ],
          ),
        ),
        Expanded(
          child: recipes.isEmpty
              ? Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.9,
                      ),
                      itemCount: recipes.length,
                      itemBuilder: (context, index) {
                        final recipe = recipes[index];
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
                                  imageUrl: "http://10.0.2.2:8000/storage/${recipe.image}",
                                  recipeContent: recipe.content,
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
                                            Icons.bookmark_border,
                                            color: Theme.of(context).colorScheme.primary,
                                          ),
                                          tooltip: "save".tr,
                                          onPressed: () {
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
                                            recipe.name,
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
                                            Helper.shareRecipe("http://10.0.2.2:8000/api/app/recipes/${recipe.id}");
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
                  ),
                ),
        ),
      ],
    );
  }
}
