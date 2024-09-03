import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:food_app/core/components/snackbars.dart';
import 'package:food_app/core/components/appbar.dart';
import 'package:food_app/core/components/drawer.dart';
import 'package:food_app/core/models/route_models.dart';
import 'package:food_app/view/home.dart';
import 'package:food_app/view/recipes.dart';
import 'package:food_app/view/auth/profile.dart';
// import 'package:google_fonts/google_fonts.dart';

class CustomBottomNavigation extends StatefulWidget {
  const CustomBottomNavigation({super.key});

  @override
  _CustomBottomNavigationState createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _authData());
  }

  final List<Widget> _children = [
    const HomeView(),
    const RecipesView(),
    const ProfileView(),
    // SignUpView(),
  ];
  var customerLogin = false.obs;

  void onTabTapped(int index) {
    RootIndex.navigationIndex.value = index;
  }

  Future<void> _authData() async {
    final prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('access_token');
    int? customerId = prefs.getInt('customerId');
    bool? isLoggedIn = prefs.getBool('isLoggedIn');
    print('bottom navigation');
    print('token: $token');
    print('customerId: $customerId');
    print('isLoggedIn: $isLoggedIn');
    if (token != null || customerId != null || isLoggedIn != null) {
      setState(() {
        customerLogin.value = isLoggedIn ?? false;
      });
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // void _updateSelectedIndex(int index) {
  //   setState(() {
  //     RootIndex.navigationIndex.value = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        extendBodyBehindAppBar: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        key: _scaffoldKey,
        appBar: const CustomAppBar(),
        drawer: const CustomDrawer(),
        body: SafeArea(
          child: _children[RootIndex.navigationIndex.value],
        ),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            if (index == 2 && !customerLogin.value) {
              SnackBars.infoSnackBar(message: 'please_sign_in_to_view_your_profile'.tr);
            } else {
              setState(() {
                RootIndex.navigationIndex.value = index;
              });
            }
          },
          backgroundColor: Theme.of(context).colorScheme.background,
          indicatorColor: Colors.grey[400],
          selectedIndex: RootIndex.navigationIndex.value,
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.home),
              label: "home".tr,
            ),
            NavigationDestination(
              icon: const Icon(Icons.list_alt),
              label: "_recipes".tr,
            ),
            NavigationDestination(
              icon: Icon(
                Icons.account_circle,
                color: customerLogin.value ? Theme.of(context).colorScheme.primary : Colors.grey,
              ),
              label: "profile".tr,
            ),
          ],
        ),
      ),
    );
  }
}
