import 'package:food_app/core/navigation/routes.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckCustomerAuth {
  static Future<Map<String, dynamic>> checkAuth() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    int? customerId = prefs.getInt('customerId');
    bool? isLoggedIn = prefs.getBool('isLoggedIn');

    if (token == null || customerId == null || isLoggedIn == null) {
      // SnackBars.warningSnackBar(message: 'Profil sayfasına erişebilmek için giriş yapmanız gerekmektedir.');
      Get.toNamed(Routes.home);
    }

    print('token: $token');
    print('customerId: $customerId');
    print('isLoggedIn: $isLoggedIn');

    return {'token': token, 'customerId': customerId, 'isLoggedIn': isLoggedIn};
  }

  static Future<Map<String, dynamic>> checkCustomer() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    int? customerId = prefs.getInt('customerId');
    bool? isLoggedIn = prefs.getBool('isLoggedIn');

    if (token == null || customerId == null || isLoggedIn == null) {
      return {'token': token, 'customerId': customerId, 'isLoggedIn': isLoggedIn};
    }

    return {'token': token, 'customerId': customerId, 'isLoggedIn': isLoggedIn};
  }
}
