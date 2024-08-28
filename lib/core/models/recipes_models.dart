class Recipe {
  final int id;
  final String name;
  final String image;
  final String content;
  final int likesCount;
  final int recordCount;
  final int categoryId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Recipe({
    required this.id,
    required this.name,
    required this.image,
    required this.content,
    required this.likesCount,
    required this.recordCount,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      content: json['content'],
      likesCount: json['likes_count'],
      recordCount: json['record_count'],
      categoryId: json['category_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'content': content,
      'likes_count': likesCount,
      'record_count': recordCount,
      'category_id': categoryId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
