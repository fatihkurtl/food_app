import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food_app/core/widgets/profile/no_recipes.dart';
import 'package:food_app/core/components/loading.dart';
import 'package:food_app/core/components/snackbars.dart';
import 'package:food_app/core/helpers/customers_auth.dart';
import 'package:food_app/core/models/customer_model.dart';
import 'package:food_app/core/services/api.dart';
import 'package:food_app/utils/constants.dart';
import 'package:food_app/view/auth/edit_profile.dart';
import 'package:food_app/view/recipe_detail.dart';
import 'package:food_app/core/helpers/recipes.dart';
import 'package:food_app/core/middlewares/check_auth.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  var customerData = Rx<Customer?>(null);
  final _mounted = false.obs;

  @override
  void initState() {
    super.initState();
    _mounted.value = true;
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    await CheckCustomerAuth.checkAuth();
    final data = await CheckCustomerAuth.checkCustomer();
    final profileData = await CustomerAuthHelper.getCustomerProfile(data['token'], data['customerId']);

    if (_mounted.value) {
      setState(() {
        customerData.value = profileData['body'] as Customer;
      });
    }
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
    return customerData.value == null
        ? Center(
            child: CustomLoading(
              color: Theme.of(context).colorScheme.secondary,
            ),
          )
        : Obx(
            () => SingleChildScrollView(
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
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: customerData.value!.favoriteRecipes!.length,
                        itemBuilder: (context, index) {
                          final recipe = customerData.value!.favoriteRecipes![index];
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
                                    commentCount: 0,
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
                                            icon: const Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                removeRecipe(recipe.id);
                                              });

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
                      ),
                    if (customerData.value?.favoriteRecipes == null || customerData.value?.favoriteRecipes!.isEmpty == true) const NoRecipes()
                  ],
                ),
              ),
            ),
          );
  }
}
