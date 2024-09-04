import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';

class NoRecipes extends StatelessWidget {
  const NoRecipes({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "you_have_no_saved_recipes".tr,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SvgPicture.asset(
          "lib/assets/icons/no_recipes.svg",
          width: 100,
          height: 100,
          allowDrawingOutsideViewBox: true,
        ),
      ],
    );
  }
}
