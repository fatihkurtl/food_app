import 'package:flutter/material.dart';
import 'package:food_app/core/components/loading.dart';
import 'package:food_app/core/components/snackbars.dart';
import 'package:food_app/core/helpers/customers_auth.dart';
import 'package:food_app/core/models/customer_model.dart';
import 'package:food_app/core/services/api.dart';
import 'package:food_app/utils/constants.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food_app/view/auth/edit_profile.dart';
import 'package:food_app/view/recipe_detail.dart';
import 'package:food_app/core/helpers/recipes.dart';
import 'package:food_app/core/middlewares/check_auth.dart';
// import 'package:food_app/core/services/api.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  var customerData = Rx<Customer?>(null);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuth();
    });
  }

  Future<void> _checkAuth() async {
    await CheckCustomerAuth.checkAuth();
    final data = await CheckCustomerAuth.checkCustomer();
    final profileData = await CustomerAuthHelper.getCustomerProfile(data['token'], data['customerId']);

    setState(() {
      customerData.value = profileData['body'] as Customer;
    });
    print('profile data: ${customerData.value?.favoriteRecipes}');
  }

  void removeRecipe(int id) async {
    final data = await CheckCustomerAuth.checkCustomer();
    final response = await ApiServices.put(Constants.removeFavoriteRecipeRoute, data['token'], {"recipe_id": id});

    if (response['statusCode'] == 200) {
      SnackBars.successSnackBar(message: 'recipe_removed_successfully');
      _checkAuth();
    } else {
      SnackBars.infoSnackBar(message: 'you_must_be_logged_in_to_remove_recipes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: customerData.value?.imageUrl != null
                  ? NetworkImage("http://10.0.2.2:8000/storage/${customerData.value?.imageUrl}") as ImageProvider<Object>
                  : const AssetImage("lib/assets/images/user.png") as ImageProvider<Object>,
            ),
            const SizedBox(height: 16),
            Text(
              customerData.value?.fullName ?? "",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              customerData.value?.email ?? "",
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ProfileEditView(),
                  ),
                );
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
            // If customerData.value.favoriteRecipes is not null, then display GridView.builder
            if (customerData.value?.favoriteRecipes != null)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.9,
                ),
                itemCount: customerData.value!.favoriteRecipes!.length,
                itemBuilder: (context, index) {
                  final recipe = customerData.value!.favoriteRecipes![index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeDetailView(
                            recipeId: recipe.id,
                            foodName: recipe.name,
                            imageUrl: recipe.image,
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
                                      recipe.id == customerData.value!.favoriteRecipes![index].id ? Icons.bookmark : Icons.bookmark_outline,
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                    tooltip: "save".tr,
                                    onPressed: () {
                                      removeRecipe(recipe.id);
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
          ],
        ),
      ),
    );
  }
}
