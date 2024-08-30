import 'package:food_app/core/components/snackbars.dart';
import 'package:food_app/core/navigation/routes.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckCustomerAuth {
  static Future<Map<String, dynamic>> checkAuth() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    int? userId = prefs.getInt('userId');
    bool? isLoggedIn = prefs.getBool('isLoggedIn');

    if (token == null || userId == null || isLoggedIn == null) {
      SnackBars.warningSnackBar(message: 'Profil sayfasına erişebilmek için giriş yapmanız gerekmektedir.');
      Get.offAllNamed(Routes.signIn);
    }

    print('token: $token');
    print('userId: $userId');
    print('isLoggedIn: $isLoggedIn');

    return {'token': token, 'userId': userId, 'isLoggedIn': isLoggedIn};
  }
}
