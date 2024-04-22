import 'package:flutter/material.dart';
import 'package:food_app/core/components/appbar.dart';
import 'package:food_app/core/components/drawer.dart';
import 'package:food_app/core/models/route_models.dart';
import 'package:food_app/view/home.dart';
import 'package:food_app/view/recipes.dart';
import 'package:food_app/view/signin.dart';
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
    const SignInView(),
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
        backgroundColor: Colors.grey[300],
        key: _scaffoldKey,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(),
        ),
        drawer: const CustomDrawer(),
        body: _children[RootIndex.navigationIndex.value],
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              RootIndex.navigationIndex.value = index;
            });
          },
          backgroundColor: Colors.grey[300],
          indicatorColor: Colors.grey[400],
          selectedIndex: RootIndex.navigationIndex.value,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: "Anasayfa",
            ),
            NavigationDestination(
              icon: Icon(Icons.list_alt),
              label: "Tarifler",
            ),
            NavigationDestination(
              icon: Icon(Icons.login),
              label: "Giriş Yap",
            ),
          ],
        ),
      ),
    );
  }
}
