import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_app/view/home.dart';
import 'package:food_app/view/recipes.dart';
import 'package:food_app/view/signin.dart';
import 'package:food_app/view/signup.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:food_app/core/models/theme_models.dart';
import 'package:food_app/core/theme/theme_provider.dart';
import 'package:food_app/core/localization/lang_provider.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await getTheme();
    });
  }

  Future<void> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('isDarkMode');
    print('isDarkMode $isDarkMode');
    if (isDarkMode != null) {
      setState(() {
        ThemeModel.isDarkMode.value = isDarkMode;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(
                child: Text(
                  "L O G O",
                  style: TextStyle(
                    fontSize: 35,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
            SwitchListTile(
              title: Text(
                ThemeModel.isDarkMode.value ? 'dark'.tr : 'light'.tr,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              activeColor: Colors.grey[300],
              inactiveThumbColor: Colors.grey[600],
              inactiveTrackColor: Colors.grey[300],
              trackOutlineColor: MaterialStateColor.resolveWith(
                (states) => Colors.grey[600]!,
              ),
              activeThumbImage: const AssetImage(
                "lib/assets/icons/dark-mode.png",
              ),
              inactiveThumbImage: const AssetImage(
                'lib/assets/icons/light-mode.png',
              ),
              value: ThemeModel.isDarkMode.value,
              onChanged: (value) {
                setState(() {
                  ThemeModel.isDarkMode.value = value;
                  Provider.of<ThemeProvider>(context, listen: false).toggleTheme(value);
                  print('value $value');
                  print('isDarkMode ${ThemeModel.isDarkMode.value}');
                });
                // Burada tema değişikliğini uygulayabilirsiniz
                // Örneğin:
                // if (isDarkMode) {
                //   Theme.of(context).brightness = Brightness.dark;
                // } else {
                //   Theme.of(context).brightness = Brightness.light;
                // }
              },
            ),
            SwitchListTile(
              title: Text(
                Get.locale == const Locale('en', 'US') ? 'English' : 'Türkçe',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              activeColor: Colors.grey[300],
              inactiveThumbColor: Colors.grey[600],
              inactiveTrackColor: Colors.grey[300],
              trackOutlineColor: MaterialStateColor.resolveWith(
                (states) => Colors.grey[600]!,
              ),
              activeThumbImage: const AssetImage(
                'lib/assets/icons/usa-flag.png',
              ),
              inactiveThumbImage: const AssetImage(
                'lib/assets/icons/tr-flag.png',
              ),
              value: Get.locale!.languageCode == 'en',
              onChanged: (value) {
                setState(() {
                  if (value) {
                    // Anahtarın değeri true ise, İngilizce dilini seçiyoruz.
                    Get.updateLocale(const Locale('en', 'US'));
                    toggleLanguage(const Locale('en', 'US'));
                  } else {
                    // Anahtarın değeri false ise, Türkçe dilini seçiyoruz.
                    Get.updateLocale(const Locale('tr', 'TR'));
                    toggleLanguage(const Locale('tr', 'TR'));
                  }
                });
              },
            ),
            // ExpansionTile(
            //   title: Text(
            //     Get.locale == const Locale('en', 'US') ? 'English' : 'Türkçe',
            //     style: TextStyle(
            //       color: Theme.of(context).colorScheme.primary,
            //     ),
            //   ),
            //   leading: Image.asset(
            //     Get.locale == const Locale('en', 'US') ? 'lib/assets/icons/usa-flag.png' : 'lib/assets/icons/tr-flag.png',
            //     width: 25,
            //     height: 25,
            //   ),
            //   childrenPadding: const EdgeInsets.only(left: 60),
            //   children: [
            //     ListTile(
            //       leading: Image.asset('lib/assets/icons/usa-flag.png', width: 25, height: 25),
            //       title: Text(
            //         "English",
            //         style: TextStyle(
            //           color: Theme.of(context).colorScheme.primary,
            //         ),
            //       ),
            //       onTap: () {
            //         Get.updateLocale(const Locale('en', 'US'));
            //         Navigator.of(context).pop();
            //         toggleLanguage(const Locale('en', 'US'));
            //       },
            //     ),
            //     ListTile(
            //       leading: Image.asset('lib/assets/icons/tr-flag.png', width: 25, height: 25),
            //       title: Text(
            //         "Türkçe",
            //         style: TextStyle(
            //           color: Theme.of(context).colorScheme.primary,
            //         ),
            //       ),
            //       onTap: () {
            //         Get.updateLocale(const Locale('tr', 'TR'));
            //         Navigator.of(context).pop();
            //         toggleLanguage(const Locale('tr', 'TR'));
            //       },
            //     ),
            //   ],
            // ),
            ListTile(
              leading: Icon(
                Icons.home_filled,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text(
                'Home',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const HomeView(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.list_alt,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text(
                'Recipes',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const RecipesView(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.login,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text(
                'Sign In',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SignInView(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.login,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text(
                'Sign Up',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SignUpView(),
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
