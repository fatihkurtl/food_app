import "package:flutter/material.dart";
// import "package:google_fonts/google_fonts.dart";

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        "TARİFİM OLSUN",
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.menu,
        ),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      centerTitle: true,
    );
  }
}
