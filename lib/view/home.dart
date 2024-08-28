import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_app/core/models/carousel_models.dart';
import 'package:food_app/core/models/recipes_models.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food_app/core/models/route_models.dart';
import 'package:food_app/core/widgets/home/build_card.dart';
import 'package:food_app/view/recipe_detail.dart';
import 'package:food_app/core/helpers/helper.dart';

import 'package:food_app/core/widgets/home/carousel_slider.dart';
// import 'package:food_app/core/components/appbar.dart';
// import 'package:food_app/core/components/drawer.dart';
// import 'package:food_app/view/recipes.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var carousels = <Carousel>[].obs;
  var popularRecipes = <Recipe>[].obs;

  @override
  void initState() {
    super.initState();
    fetchCarousels();
    fetchPopularRecipes();
  }

  Future<void> fetchCarousels() async {
    await Helper.getAllCarousels();
    setState(() {
      carousels.value = Helper.carousels;
    });
  }

  Future<void> fetchPopularRecipes() async {
    await Helper.getPopularRecipes();
    setState(() {
      popularRecipes.value = Helper.popularRecipes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: CarouselWidget(carousels: carousels),
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
              children: popularRecipes.map((recipe) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: BuildCard(
                    recipeId: recipe.id,
                    foodName: recipe.name,
                    imageUrl: recipe.image,
                    recipeContent: recipe.content,
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
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  if (kDebugMode) {
                    print('Tapped Recipes $index');
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeDetailView(
                          recipeId: index, foodName: "Food", imageUrl: "https://www.recipetineats.com/wp-content/uploads/2021/08/Garden-Salad_47-SQ.jpg", recipeContent: 'aaaaaaaaaaaaaa'),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(10),
                    // boxShadow: const [
                    //   BoxShadow(
                    //     color: Colors.grey,
                    //     blurRadius: 5,
                    //     spreadRadius: 0.5,
                    //     offset: Offset(0, 2),
                    //   ),
                    // ],
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
                            "https://www.recipetineats.com/wp-content/uploads/2021/08/Garden-Salad_47-SQ.jpg",
                            fit: BoxFit.cover,
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
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                "Food",
                                style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                  textStyle: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                textAlign: TextAlign.center,
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
                                  Helper.shareRecipe("recipe url");
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
        ],
      ),
    );
  }
}
