import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_app/view/recipe_detail.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildCard extends StatefulWidget {
  final int recipeId;
  final String foodName;
  final String imageUrl;
  final String recipeContent;

  const BuildCard({
    super.key,
    required this.recipeId,
    required this.foodName,
    required this.imageUrl,
    required this.recipeContent,
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
              recipeId: widget.recipeId,
              foodName: widget.foodName,
              imageUrl: "http://10.0.2.2:8000/storage/${widget.imageUrl}",
              recipeContent: widget.recipeContent,
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
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.network(
                "http://10.0.2.2:8000/storage/${widget.imageUrl}",
                fit: BoxFit.cover,
                width: double.infinity,
                height: 70,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(Icons.error, color: Colors.red),
                  );
                },
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  widget.foodName,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.bebasNeue(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
