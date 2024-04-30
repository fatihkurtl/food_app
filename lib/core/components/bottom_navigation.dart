import 'package:flutter/material.dart';
import 'package:food_app/core/components/appbar.dart';
import 'package:food_app/core/components/drawer.dart';
import 'package:food_app/core/models/route_models.dart';
import 'package:food_app/view/home.dart';
import 'package:food_app/view/recipes.dart';
import 'package:food_app/view/auth/profile.dart';
import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

class CustomBottomNavigation extends StatefulWidget {
  const CustomBottomNavigation({super.key});

  @override
  _CustomBottomNavigationState createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  final List<Widget> _children = [
    const HomeView(),
    const RecipesView(),
    const ProfileView(),
    // SignUpView(),
  ];

  void onTabTapped(int index) {
    RootIndex.navigationIndex.value = index;
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
        backgroundColor: Theme.of(context).colorScheme.background,
        key: _scaffoldKey,
        appBar: const CustomAppBar(),
        drawer: const CustomDrawer(),
        body: SafeArea(
          child: _children[RootIndex.navigationIndex.value],
        ),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              RootIndex.navigationIndex.value = index;
            });
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
              icon: const Icon(Icons.account_circle),
              label: "profile".tr,
            ),
          ],
        ),
      ),
    );
  }
}
