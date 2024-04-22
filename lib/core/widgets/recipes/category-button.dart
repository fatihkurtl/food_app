import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryButton extends StatelessWidget {
  final String text;

  const CategoryButton({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (kDebugMode) {
          print("Category Button Pressed: $text");
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Colors.grey[500],
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.normal,
          color: Colors.grey[200],
          textStyle: const TextStyle(
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
