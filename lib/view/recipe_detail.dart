import 'package:flutter/material.dart';
import 'package:food_app/core/components/loading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class RecipeDetailView extends StatefulWidget {
  final int recipeId;
  final String foodName;
  final String? foodNameEn;
  final String imageUrl;
  final int likesCount;
  final int commentCount;
  final String recipeContent;
  final String? recipeContentEn;

  const RecipeDetailView({
    Key? key,
    required this.recipeId,
    required this.imageUrl,
    required this.foodName,
    this.foodNameEn,
    required this.recipeContent,
    this.recipeContentEn,
    required this.likesCount,
    required this.commentCount,
  }) : super(key: key);

  @override
  _RecipeDetailViewState createState() => _RecipeDetailViewState();
}

class _RecipeDetailViewState extends State<RecipeDetailView> {
  final TextEditingController _commentController = TextEditingController();
  final List<String> _comments = [];
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                Get.locale?.languageCode == "tr" ? widget.foodName : widget.foodNameEn ?? widget.foodName,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [Shadow(color: Colors.black.withOpacity(0.3), blurRadius: 5)],
                ),
              ),
              background: Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.white),
                onPressed: () {
                  setState(() {
                    _isFavorite = !_isFavorite;
                  });
                  // TODO: Implement favorite functionality
                },
              ),
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: () {
                  // TODO: Implement share functionality
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.favorite, color: Theme.of(context).colorScheme.primary),
                          SizedBox(width: 8),
                          Text(
                            '${widget.likesCount}',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.comment, color: Theme.of(context).colorScheme.primary),
                          SizedBox(width: 8),
                          Text(
                            '${widget.commentCount}',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    "ingredients".tr,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  MarkdownBody(
                    data: Get.locale?.languageCode == "tr" ? widget.recipeContent : widget.recipeContentEn ?? widget.recipeContent,
                    styleSheet: MarkdownStyleSheet(
                      p: GoogleFonts.roboto(fontSize: 16),
                      listBullet: GoogleFonts.roboto(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "comments".tr,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  color: isDarkMode ? Colors.grey[800] : Colors.white,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      child: Text(
                        _comments[index][0].toUpperCase(),
                        style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                      ),
                    ),
                    title: Text(
                      _comments[index],
                      style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                    ),
                  ),
                );
              },
              childCount: _comments.length,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 80), // Yorum giriş alanı için boşluk
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        color: isDarkMode ? Colors.grey[900] : Colors.grey[100],
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _commentController,
                  style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                  decoration: InputDecoration(
                    hintText: "add_comment".tr,
                    hintStyle: TextStyle(
                      color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    ),
                    filled: true,
                    fillColor: isDarkMode ? Colors.grey[700] : Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.send,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {
                  if (_commentController.text.isNotEmpty) {
                    setState(() {
                      _comments.add(_commentController.text);
                      _commentController.clear();
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}
