import 'package:flutter/material.dart';
import 'package:food_app/core/components/loading.dart';
import 'package:food_app/core/state/app_data.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food_app/core/models/route_models.dart';
import 'package:food_app/core/widgets/home/build_card.dart';
import 'package:food_app/view/recipe_detail.dart';
import 'package:food_app/core/helpers/recipes.dart';

import 'package:food_app/core/widgets/home/carousel_slider.dart';
import 'package:food_app/core/state/recipes_data.dart';
// import 'package:food_app/core/components/appbar.dart';
// import 'package:food_app/core/components/drawer.dart';
// import 'package:food_app/view/recipes.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // var carousels = <Carousel>[].obs;
  // var popularRecipes = <Recipe>[].obs;
  // var recipes = <Recipe>[].obs;
  var recipeData = RecipeState();
  var carouselList = AppState();

  @override
  void initState() {
    super.initState();
    fetchCarousels();
    fetchPopularRecipes();
    fetchRecipes();
  }

  Future<void> fetchCarousels() async {
    await RecipesHelper.getAllCarousels();
    if (mounted) {
      carouselList.carousels.value = RecipesHelper.carousels;
      setState(() {});
    }
  }

  Future<void> fetchPopularRecipes() async {
    await RecipesHelper.getPopularRecipes();
    if (mounted) {
      recipeData.popularRecipes.value = RecipesHelper.popularRecipes;
      setState(() {});
    }
  }

  Future<void> fetchRecipes() async {
    await RecipesHelper.getAllRecipes();
    if (mounted) {
      recipeData.recipes.value = RecipesHelper.recipes.take(4).toList();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return recipeData.recipes.isEmpty && carouselList.carousels.isEmpty && recipeData.popularRecipes.isEmpty
        ? Center(
            child: CustomLoading(
              color: Theme.of(context).colorScheme.secondary,
            ),
          )
        : Obx(
            () => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: CarouselWidget(carousels: carouselList.carousels),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 5,
                        ),
                        child: Text(
                          "populer_recipes".tr,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            fontFamily: GoogleFonts.bebasNeue().fontFamily,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: recipeData.popularRecipes.map((recipe) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: BuildCard(
                            recipeId: recipe.id,
                            foodName: recipe.name,
                            foodNameEn: recipe.nameEn,
                            imageUrl: recipe.image,
                            recipeContent: recipe.content,
                            recipeContentEn: recipe.contentEn,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 5,
                        ),
                        child: Text(
                          "recipes".tr,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.bebasNeue().fontFamily,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: TextButton(
                          onPressed: () {
                            RootIndex.navigationIndex.value = 1;
                          },
                          child: Text(
                            "see_all".tr,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.9,
                        ),
                        itemCount: recipeData.recipes.length,
                        itemBuilder: (context, index) {
                          final recipe = recipeData.recipes[index];
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
                                    likesCount: recipe.likesCount,
                                    commentCount: 6,
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
                                              RecipesHelper.shareRecipe("http://10.0.2.2:8000/api/app/recipes/${recipe.name}");
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
                ],
              ),
            ),
          );
  }
}
