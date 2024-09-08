import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryButton extends StatelessWidget {
  final int categoryId;
  final int selectedCategoryId;
  final String text;
  final String? textEn;
  final void Function(int) onSelect;

  const CategoryButton({
    Key? key,
    required this.categoryId,
    required this.selectedCategoryId,
    required this.text,
    required this.textEn,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSelected = categoryId == selectedCategoryId;
    return GestureDetector(
      onTap: () {
        onSelect(categoryId);
        if (kDebugMode) {
          print("Selected Category: $text");
          print(Get.locale);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ]
              : [],
        ),
        child: Text(
          Get.locale?.languageCode == "tr" ? text : textEn ?? text,
          style: GoogleFonts.roboto(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.primary,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
