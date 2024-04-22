import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

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
        "TARİFİM OLSUN",
        style: TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: GoogleFonts.bebasNeue().fontFamily,
        ),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.menu,
          color: Colors.grey[600],
        ),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      centerTitle: true,
    );
  }
}
