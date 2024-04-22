import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_app/view/recipe_detail.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildCard extends StatefulWidget {
  final String foodName;
  final String imageUrl;

  const BuildCard({
    super.key,
    required this.foodName,
    required this.imageUrl,
  });

  @override
  _BuildCardState createState() => _BuildCardState();
}

class _BuildCardState extends State<BuildCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (kDebugMode) {
          print('Tapped ${widget.foodName}');
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailView(
              recipeId: 1,
              imageUrl: widget.imageUrl,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              // clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 70,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              widget.foodName,
              style: GoogleFonts.bebasNeue(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
