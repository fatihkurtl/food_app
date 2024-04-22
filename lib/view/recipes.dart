import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:food_app/core/widgets/recipes/category-button.dart';
import 'package:food_app/view/recipe_detail.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:food_app/core/components/appbar.dart';
// import 'package:food_app/core/components/bottom-navigation.dart';
// import 'package:food_app/core/components/drawer.dart';
import 'package:google_fonts/google_fonts.dart';

class RecipesView extends StatefulWidget {
  const RecipesView({super.key});

  @override
  _RecipesViewState createState() => _RecipesViewState();
}

class _RecipesViewState extends State<RecipesView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border.all(
                color: Colors.grey[300]!,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 0.0),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Tariflerde ara...",
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
          child: Padding(
            padding: EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              bottom: 8.0,
              top: 0.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CategoryButton(
                  text: 'Ana Yemekler',
                ),
                SizedBox(width: 10),
                CategoryButton(
                  text: 'Çorbalar',
                ),
                SizedBox(width: 10),
                CategoryButton(
                  text: 'Salatalar',
                ),
                SizedBox(width: 10),
                CategoryButton(
                  text: 'Kahvaltılıklar',
                ),
                SizedBox(width: 10),
                CategoryButton(
                  text: 'Tatlılar',
                ),
                SizedBox(width: 10),
                CategoryButton(
                  text: 'İçecekler',
                ),
                SizedBox(width: 10),
                CategoryButton(
                  text: 'Vegan / Vejetaryen',
                ),
                SizedBox(width: 10),
                CategoryButton(
                  text: 'Makarnalar',
                ),
                SizedBox(width: 10),
                CategoryButton(
                  text: 'Dünya Mutfakları',
                ),
                SizedBox(width: 10),
                CategoryButton(
                  text: 'Sağlıklı Tarifler',
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.9,
                ),
                itemCount: 16,
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
                            recipeId: index,
                            foodName: "Food",
                            imageUrl: "https://www.recipetineats.com/wp-content/uploads/2021/08/Garden-Salad_47-SQ.jpg",
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
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
                                    icon: const Icon(
                                      Icons.bookmark_border,
                                      color: Colors.black,
                                    ),
                                    tooltip: "Kaydet",
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
                                      color: Colors.black,
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
                                    icon: const Icon(
                                      Icons.share,
                                      color: Colors.black,
                                    ),
                                    tooltip: "Paylaş",
                                    onPressed: () {
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
