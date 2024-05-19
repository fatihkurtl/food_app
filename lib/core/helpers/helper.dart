import 'package:flutter/foundation.dart';
import 'package:share_plus/share_plus.dart';

class Helper {
  static void shareRecipe(String recipeUrl) {
    if (kDebugMode) {
      print('Shared Recipe: $recipeUrl');
    }
    Share.share('Check out this recipe: $recipeUrl');
  }
}
