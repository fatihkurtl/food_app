import 'package:get/get.dart';
import 'package:food_app/core/navigation/routes.dart';
import 'package:food_app/view/signup.dart';
import 'package:food_app/view/signin.dart';
import 'package:food_app/view/home.dart';
import 'package:food_app/view/recipes.dart';
import 'package:food_app/view/recipe_detail.dart';

abstract class AppViews {
  static final views = [
    GetPage(
      name: Routes.signup,
      page: () => const SignUpView(),
    ),
    GetPage(
      name: Routes.signin,
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
      name: Routes.recipeDetail,
      page: () => const RecipeDetailView(
        recipeId: 0,
      ),
    ),
  ];
}
