import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:food_app/core/models/route_models.dart';
import 'package:food_app/core/widgets/home/build_card.dart';
import 'package:food_app/view/recipe_detail.dart';
// import 'package:food_app/core/components/appbar.dart';
// import 'package:food_app/core/components/drawer.dart';
// import 'package:food_app/view/recipes.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<String> sliderImages = [
    'https://www.medibank.com.au/content/dam/livebetter/en/images/migrated/324538f6338f4a575843949de2a7d960/healthy-cooking.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRE7-oELEJYx08UvT6L_1YBF9LZtqMORFpIvYWCSqm_uxZGvzKWXFw7qXEE587FtAIyLHE&usqp=CAU',
    'https://www.hsph.harvard.edu/nutritionsource/wp-content/uploads/sites/30/2018/11/shutterstock_484530181.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxPx2ASfhdRKcXjiLAhZ0CvosEffkutIUqQG0OhIaeAw&s',
    'https://www.trillmag.com/wp-content/uploads/2023/05/shutterstock_271174232-1.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
            ),
            child: CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
              ),
              items: sliderImages.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      // child: Text(
                      //   'text $i',
                      //   style: const TextStyle(
                      //     fontSize: 16.0,
                      //   ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        child: Image.network(
                          i.toString(),
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
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
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BuildCard(
                  foodName: "Burger",
                  imageUrl: "https://static.vecteezy.com/system/resources/thumbnails/019/023/604/small_2x/front-view-tasty-meat-burger-with-cheese-and-salad-free-photo.jpg",
                ),
                SizedBox(width: 10),
                BuildCard(
                  foodName: "Pizza",
                  imageUrl:
                      "https://www.allrecipes.com/thmb/fFW1o307WSqFFYQ3-QXYVpnFj6E=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/48727-Mikes-homemade-pizza-DDMFS-beauty-4x3-BG-2974-a7a9842c14e34ca699f3b7d7143256cf.jpg",
                ),
                SizedBox(width: 10),
                BuildCard(
                  foodName: "Pasta",
                  imageUrl: "https://savvybites.co.uk/wp-content/uploads/2023/12/Creamy-tomato-pasta-2.jpg",
                ),
                SizedBox(width: 10),
                BuildCard(
                  foodName: "Salad",
                  imageUrl: "https://www.recipetineats.com/wp-content/uploads/2021/08/Garden-Salad_47-SQ.jpg",
                ),
                SizedBox(width: 10),
                BuildCard(
                  foodName: "Burger",
                  imageUrl: "https://static.vecteezy.com/system/resources/thumbnails/019/023/604/small_2x/front-view-tasty-meat-burger-with-cheese-and-salad-free-photo.jpg",
                ),
                SizedBox(width: 10),
                BuildCard(
                  foodName: "Pizza",
                  imageUrl:
                      "https://www.allrecipes.com/thmb/fFW1o307WSqFFYQ3-QXYVpnFj6E=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/48727-Mikes-homemade-pizza-DDMFS-beauty-4x3-BG-2974-a7a9842c14e34ca699f3b7d7143256cf.jpg",
                ),
                SizedBox(width: 10),
                BuildCard(
                  foodName: "Pasta",
                  imageUrl: "https://savvybites.co.uk/wp-content/uploads/2023/12/Creamy-tomato-pasta-2.jpg",
                ),
                SizedBox(width: 10),
                BuildCard(
                  foodName: "Salad",
                  imageUrl: "https://www.recipetineats.com/wp-content/uploads/2021/08/Garden-Salad_47-SQ.jpg",
                ),
              ],
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
