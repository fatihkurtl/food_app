import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RecipeDetailView extends StatefulWidget {
  final int recipeId;
  final String foodName;
  final String imageUrl;

  const RecipeDetailView({super.key, required this.recipeId, required this.imageUrl, required this.foodName});

  @override
  _RecipeDetailViewState createState() => _RecipeDetailViewState();
}

class _RecipeDetailViewState extends State<RecipeDetailView> {
  late int recipeId;
  late String imageUrl;

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print("Detail View, Recipe ID: ${widget.recipeId}");
    }

    recipeId = widget.recipeId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            Icons.arrow_back,
            color: Colors.grey[600],
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Tarif ID: ${widget.recipeId}",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                  textStyle: const TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Tarif Adı: ${widget.foodName}",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                  textStyle: const TextStyle(
                    fontSize: 24,
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
