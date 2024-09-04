import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryButton extends StatefulWidget {
  final int categoryId;
  final int selectedCategoryId;
  final String text;
  final String? textEn;
  final void Function(int) onSelect;

  const CategoryButton({
    super.key,
    required this.categoryId,
    required this.selectedCategoryId,
    required this.text,
    required this.textEn,
    required this.onSelect,
  });

  @override
  _CategoryButtonState createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  int previouslySelectedId = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.onSelect(widget.categoryId);
        previouslySelectedId = widget.categoryId;
        if (kDebugMode) {
          print("Selected Category: ${widget.text}");
          print(Get.locale);
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          widget.categoryId == widget.selectedCategoryId ? Theme.of(context).colorScheme.background : Theme.of(context).colorScheme.secondary,
        ),
      ),
      child: Text(
        Get.locale?.languageCode == "tr" ? widget.text : widget.textEn ?? widget.text,
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.normal,
          color: Theme.of(context).colorScheme.primary,
          textStyle: const TextStyle(
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
