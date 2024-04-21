import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey[300],
      title: Text(
        "Tarifim Olsun",
        style: GoogleFonts.bebasNeue(
          fontSize: 30,
          color: Colors.black,
        ),
      ),
      leading: IconButton(
        // iconSize: 20,
        // style: ButtonStyle(
        //   backgroundColor: MaterialStateProperty.all(
        //     Colors.deepPurple[500],
        //   ),
        //   iconSize: MaterialStateProperty.all(24),
        //   shape: MaterialStateProperty.all(
        //     RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(10),
        //     ),
        //   ),
        // ),
        icon: Icon(
          Icons.menu,
          color: Colors.grey[600],
        ),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      centerTitle: true,
      // backgroundColor: Colors.grey[300],
      // actions: [
      // ActionChip(
      //   label: Text(
      //     "Sign In",
      //     style: TextStyle(
      //       color: Colors.white,
      //     ),
      //   ),
      //   onPressed: () {
      // Get.toNamed(Routes.signin);
      //   },
      //   backgroundColor: Colors.deepPurple[500],
      // )
      //   PopupMenuButton(
      //     iconColor: Colors.deepPurple[100],
      //     color: Colors.deepPurple[100],
      //     itemBuilder: (BuildContext context) {
      //       return [
      //         const PopupMenuItem(
      //           child: Text(
      //             "Sign In",
      //             style: TextStyle(
      //               color: Colors.black,
      //             ),
      //           ),
      //         ),
      //         const PopupMenuItem(
      //           child: Text(
      //             "Sign Up",
      //             style: TextStyle(
      //               color: Colors.black,
      //             ),
      //           ),
      //         ),
      //       ];
      //     },
      //   )
      // ],
    );
  }
}
