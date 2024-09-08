import 'package:get/get.dart';
import 'package:food_app/view/home.dart';
import 'package:food_app/view/recipes.dart';
import 'package:food_app/view/auth/profile.dart';
import 'package:food_app/view/auth/edit_profile.dart';
import 'package:food_app/core/navigation/routes.dart';
import 'package:food_app/view/signup.dart';
import 'package:food_app/view/signin.dart';
import 'package:food_app/view/recipe_detail.dart';

abstract class AppViews {
  static final views = [
    GetPage(
      name: Routes.signUp,
      page: () => const SignUpView(),
    ),
    GetPage(
      name: Routes.signIn,
      page: () => const SignInView(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
    ),
    GetPage(
      name: Routes.recipes,
      page: () => const RecipesView(),
    ),
    GetPage(
      name: Routes.profile,
      page: () => const ProfileView(),
    ),
    GetPage(
      name: Routes.editProfile,
      page: () => const ProfileEditView(),
    ),
    GetPage(
      name: Routes.recipeDetail,
      page: () => const RecipeDetailView(
        recipeId: 0,
        foodName: "",
        foodNameEn: "",
        imageUrl: "",
        likesCount: 0,
        commentCount: 0,
        recipeContent: "",
        recipeContentEn: "",
      ),
    ),
  ];
}
