import 'package:flutter/material.dart';
import 'package:food_app/core/models/route_models.dart';
import 'package:get/get.dart';
// import 'package:food_app/view/home.dart';
// import 'package:food_app/view/recipes.dart';
import 'package:food_app/view/auth/edit_profile.dart';
// import 'package:food_app/view/auth/profile.dart';
import 'package:food_app/view/signin.dart';
import 'package:food_app/view/signup.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:food_app/core/models/theme_models.dart';
import 'package:food_app/core/theme/theme_provider.dart';
import 'package:food_app/core/localization/lang_provider.dart';
import 'package:food_app/core/middlewares/check_auth.dart';
import 'package:food_app/core/helpers/customers_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  var isLoggedIn = false.obs;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await getTheme();
    });
    _authData();
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

  void _updateLanguage(Locale locale) {
    setState(() {
      Get.updateLocale(locale);
    });
  }

  Future<void> _authData() async {
    final data = await CheckCustomerAuth.checkCustomer();

    if (data['isLoggedIn'] == true) {
      setState(() {
        isLoggedIn.value = true;
      });
    }
  }

  void _handleLogout() async {
    bool confirmLogout = await Get.dialog(
      AlertDialog(
        title: Text("log_out".tr),
        content: Text("are_you_sure_you_want_to_log_out".tr),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text("no".tr),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: Text("yes".tr),
          ),
        ],
      ),
    );
    if (confirmLogout == true) {
      await CustomerAuthHelper.customerLogout();
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
                child: SvgPicture.asset(
                  "lib/assets/icons/logo.svg",
                  width: 100,
                  height: 100,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                ThemeModel.isDarkMode.value ? Icons.dark_mode : Icons.light_mode,
              ),
              title: Text(
                ThemeModel.isDarkMode.value ? 'dark'.tr : 'light'.tr,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              trailing: PopupMenuButton<bool>(
                icon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      ThemeModel.isDarkMode.value ? "lib/assets/icons/dark-mode.png" : "lib/assets/icons/light-mode.png",
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
                onSelected: (bool value) {
                  setState(() {
                    ThemeModel.isDarkMode.value = value;
                    Provider.of<ThemeProvider>(context, listen: false).toggleTheme(value);
                    print('value $value');
                    print('isDarkMode ${ThemeModel.isDarkMode.value}');
                  });
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<bool>>[
                  PopupMenuItem<bool>(
                    value: true,
                    child: Row(
                      children: [
                        Image.asset(
                          "lib/assets/icons/dark-mode.png",
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 8),
                        Text("dark".tr),
                      ],
                    ),
                  ),
                  PopupMenuItem<bool>(
                    value: false,
                    child: Row(
                      children: [
                        Image.asset(
                          "lib/assets/icons/light-mode.png",
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 8),
                        Text("light".tr),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // SwitchListTile(
            //   title: Text(
            //     ThemeModel.isDarkMode.value ? 'dark'.tr : 'light'.tr,
            //     style: TextStyle(
            //       color: Theme.of(context).colorScheme.primary,
            //     ),
            //   ),
            //   activeColor: Colors.transparent,
            //   inactiveThumbColor: Colors.transparent,
            //   activeTrackColor: Colors.transparent,
            //   inactiveTrackColor: Colors.transparent,
            //   trackColor: MaterialStateColor.resolveWith(
            //     (states) => Colors.transparent,
            //   ),
            //   trackOutlineColor: MaterialStateColor.resolveWith(
            //     (states) => Colors.grey[600]!,
            //   ),
            //   activeThumbImage: const AssetImage(
            //     "lib/assets/icons/dark-mode.png",
            //   ),
            //   inactiveThumbImage: const AssetImage(
            //     "lib/assets/icons/light-mode.png",
            //   ),
            //   value: ThemeModel.isDarkMode.value,
            //   onChanged: (value) {
            //     setState(() {
            //       ThemeModel.isDarkMode.value = value;
            //       Provider.of<ThemeProvider>(context, listen: false).toggleTheme(value);
            //       print('value $value');
            //       print('isDarkMode ${ThemeModel.isDarkMode.value}');
            //     });
            //     // Burada tema değişikliğini uygulayabilirsiniz
            //     // Örneğin:
            //     // if (isDarkMode) {
            //     //   Theme.of(context).brightness = Brightness.dark;
            //     // } else {
            //     //   Theme.of(context).brightness = Brightness.light;
            //     // }
            //   },
            // ),
            ListTile(
              leading: Icon(
                Icons.language,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text(
                Get.locale == const Locale("en", "US") ? "English" : "Türkçe",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              trailing: PopupMenuButton<Locale>(
                icon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      Get.locale == const Locale("en", "US") ? "lib/assets/icons/usa-flag.png" : "lib/assets/icons/tr-flag.png",
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
                onSelected: (Locale locale) {
                  _updateLanguage(locale);
                  Get.locale == const Locale("en", "US") ? toggleLanguage(const Locale("en", "US")) : toggleLanguage(const Locale("tr", "US"));
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<Locale>>[
                  PopupMenuItem<Locale>(
                    value: const Locale("en", "US"),
                    child: Row(
                      children: [
                        Image.asset(
                          "lib/assets/icons/usa-flag.png",
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 8),
                        const Text("English"),
                      ],
                    ),
                  ),
                  PopupMenuItem<Locale>(
                    value: const Locale("tr", "TR"),
                    child: Row(
                      children: [
                        Image.asset(
                          "lib/assets/icons/tr-flag.png",
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 8),
                        const Text("Türkçe"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // SwitchListTile(
            //   title: Text(
            //     Get.locale == const Locale("en", "US") ? "English" : "Türkçe",
            //     style: TextStyle(
            //       color: Theme.of(context).colorScheme.primary,
            //     ),
            //   ),
            //   activeColor: Colors.transparent,
            //   inactiveThumbColor: Colors.transparent,
            //   activeTrackColor: Colors.transparent,
            //   inactiveTrackColor: Colors.transparent,
            //   trackColor: MaterialStateColor.resolveWith(
            //     (states) => Colors.transparent,
            //   ),
            //   trackOutlineColor: MaterialStateColor.resolveWith(
            //     (states) => Colors.grey[600]!,
            //   ),
            //   activeThumbImage: const AssetImage(
            //     "lib/assets/icons/usa-flag.png",
            //   ),
            //   inactiveThumbImage: const AssetImage(
            //     "lib/assets/icons/tr-flag.png",
            //   ),
            //   value: Get.locale!.languageCode == 'en',
            //   onChanged: (value) {
            //     setState(() {
            //       if (value) {
            //         Get.updateLocale(const Locale("en", "US"));
            //         toggleLanguage(const Locale("en", "US"));
            //       } else {
            //         Get.updateLocale(const Locale("tr", "TR"));
            //         toggleLanguage(const Locale("tr", "TR"));
            //       }
            //     });
            //   },
            // ),
            if (isLoggedIn.value == true)
              ListTile(
                leading: Icon(
                  Icons.person,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(
                  "edit_profile".tr,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ProfileEditView(),
                    ),
                  );
                },
              ),
            if (isLoggedIn.value == true)
              ListTile(
                title: Text(
                  "saved_recipes".tr,
                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                leading: Icon(
                  Icons.bookmark,
                  color: Theme.of(context).colorScheme.primary,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onTap: () {
                  RootIndex.navigationIndex.value = 2;
                  Navigator.of(context).pop();
                },
              ),
            if (isLoggedIn.value == false)
              ListTile(
                leading: Icon(
                  Icons.login,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(
                  "sign_in".tr,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SignInView(),
                    ),
                  );
                },
              ),
            if (isLoggedIn.value == false)
              ListTile(
                leading: Icon(
                  Icons.person_add,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(
                  "sign_up".tr,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SignUpView(),
                    ),
                  );
                },
              ),
            ListTile(
              title: Text(
                "settings".tr,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              leading: Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.primary,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            if (isLoggedIn.value == true)
              ListTile(
                title: Text(
                  "logout".tr,
                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                leading: Icon(
                  Icons.logout,
                  color: Theme.of(context).colorScheme.primary,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onTap: () {
                  _handleLogout();
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
            //////////////////////////////////////////////
            // ListTile(
            //   leading: Icon(
            //     Icons.home_filled,
            //     color: Theme.of(context).colorScheme.primary,
            //   ),
            //   title: Text(
            //     'Home',
            //     style: TextStyle(
            //       color: Theme.of(context).colorScheme.primary,
            //     ),
            //   ),
            //   onTap: () {
            //     Navigator.of(context).push(
            //       MaterialPageRoute(
            //         builder: (context) => const HomeView(),
            //       ),
            //     );
            //   },
            // ),
            // ListTile(
            //   leading: Icon(
            //     Icons.list_alt,
            //     color: Theme.of(context).colorScheme.primary,
            //   ),
            //   title: Text(
            //     'Recipes',
            //     style: TextStyle(
            //       color: Theme.of(context).colorScheme.primary,
            //     ),
            //   ),
            //   onTap: () {
            //     Navigator.of(context).push(
            //       MaterialPageRoute(
            //         builder: (context) => const RecipesView(),
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
