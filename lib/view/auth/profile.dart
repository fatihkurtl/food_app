import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food_app/view/recipe_detail.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("lib/assets/images/user.png"),
            ),
            const SizedBox(height: 16),
            Text(
              "John Doe",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "john.doe@example.com",
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: Profil düzenleme sayfasına git
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
              child: Text(
                "edit_profile".tr,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Divider(
              color: Theme.of(context).colorScheme.primary,
              height: 1,
            ),
            const SizedBox(height: 16),
            Text(
              "saved_recipes".tr,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            GridView.builder(
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
      ),
    );
  }
}
