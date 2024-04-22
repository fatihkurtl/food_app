import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryButton extends StatefulWidget {
  final String text;

  const CategoryButton({
    super.key,
    required this.text,
  });

  @override
  _CategoryButtonState createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (kDebugMode) {
          print("Selected Category: ${widget.text}");
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          _isPressed ? Colors.grey[700] : Colors.grey[500],
        ),
      ),
      child: Text(
        widget.text,
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
