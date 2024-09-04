import 'package:flutter/material.dart';
import 'package:food_app/core/components/loading.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class RecipeDetailView extends StatefulWidget {
  final int recipeId;
  final String foodName;
  final String? foodNameEn;
  final String imageUrl;
  final String recipeContent;
  final String? recipeContentEn;

  const RecipeDetailView({
    super.key,
    required this.recipeId,
    required this.imageUrl,
    required this.foodName,
    this.foodNameEn,
    required this.recipeContent,
    this.recipeContentEn,
  });

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
    return recipeId == 0 && imageUrl == '' && widget.recipeContent == ''
        ? Center(
            child: CustomLoading(
              color: Theme.of(context).colorScheme.secondary,
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.background,
              title: Text(
                "recipe_app".tr,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.bebasNeue().fontFamily,
                ),
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              centerTitle: true,
            ),
            body: Markdown(
              data: """
![Image](${widget.imageUrl})
# ${Get.locale?.languageCode == "tr" ? widget.foodName : widget.foodNameEn ?? widget.foodName}
${Get.locale?.languageCode == "tr" ? widget.recipeContent : widget.recipeContentEn ?? widget.recipeContent}
            """,
              styleSheet: MarkdownStyleSheet(
                h1: const TextStyle(fontSize: 24),
                h2: const TextStyle(fontSize: 20),
                a: const TextStyle(color: Colors.blue),
              ),
            ),
          );
  }
}
