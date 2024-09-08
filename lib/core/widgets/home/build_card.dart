import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_app/view/recipe_detail.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildCard extends StatelessWidget {
  final int recipeId;
  final String foodName;
  final String foodNameEn;
  final String imageUrl;
  final String recipeContent;
  final String recipeContentEn;

  const BuildCard({
    Key? key,
    required this.recipeId,
    required this.foodName,
    required this.foodNameEn,
    required this.imageUrl,
    required this.recipeContent,
    required this.recipeContentEn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (kDebugMode) {
          print('Tapped $foodName');
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailView(
              recipeId: recipeId,
              foodName: foodName,
              foodNameEn: foodNameEn,
              imageUrl: "http://10.0.2.2:8000/storage/$imageUrl",
              likesCount: 0,
              commentCount: 0,
              recipeContent: recipeContent,
              recipeContentEn: recipeContentEn,
            ),
          ),
        );
      },
      child: Container(
        width: 100,
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                "http://10.0.2.2:8000/storage/$imageUrl",
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(Icons.error, color: Colors.red),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.transparent,
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  foodName,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
