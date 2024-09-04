class Customer {
  final int id;
  final String fullName;
  final String? imageUrl;
  final String email;
  final String? gender;
  final int? age;
  final List<FavoriteRecipe>? favoriteRecipes;

  Customer({
    required this.id,
    required this.fullName,
    this.imageUrl,
    required this.email,
    this.gender,
    this.age,
    this.favoriteRecipes,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    var customerJson = json['customer'];
    var favoriteRecipesJson = json['favoriteRecipes'] as List<dynamic>?;

    return Customer(
      id: customerJson['id'] ?? 0,
      fullName: customerJson['full_name'] ?? '',
      imageUrl: customerJson['profile_photo_path'] as String?,
      email: customerJson['email'] ?? '',
      gender: customerJson['gender'] as String?,
      age: customerJson['age'] as int?,
      favoriteRecipes: favoriteRecipesJson != null ? favoriteRecipesJson.map((e) => FavoriteRecipe.fromJson(e)).toList() : [],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'full_name': fullName,
        'profile_photo_path': imageUrl,
        'email': email,
        'gender': gender,
        'age': age,
        'favorite_recipes': favoriteRecipes?.map((e) => e.toJson()).toList() ?? [],
      };
}

class FavoriteRecipe {
  final int id;
  final String name;
  final String nameEn;
  final String image;
  final String content;
  final String contentEn;
  final int likesCount;
  final int recordCount;
  final int categoryId;
  final String createdAt;
  final String updatedAt;

  FavoriteRecipe({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.image,
    required this.content,
    required this.contentEn,
    required this.likesCount,
    required this.recordCount,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FavoriteRecipe.fromJson(Map<String, dynamic> json) {
    return FavoriteRecipe(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      nameEn: json['name_en'] ?? '',
      image: json['image'] ?? '',
      content: json['content'] ?? '',
      contentEn: json['content_en'] ?? '',
      likesCount: json['likes_count'] ?? 0,
      recordCount: json['record_count'] ?? 0,
      categoryId: json['category_id'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'name_en': nameEn,
        'image': image,
        'content': content,
        'content_en': contentEn,
        'likes_count': likesCount,
        'record_count': recordCount,
        'category_id': categoryId,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };

  @override
  String toString() {
    return 'FavoriteRecipe{id: $id, name: $name, nameEn: $nameEn, image: $image, content: $content, contentEn: $contentEn, likesCount: $likesCount, recordCount: $recordCount, categoryId: $categoryId, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
