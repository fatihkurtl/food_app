class Categories {
  final int id;
  final String name;
  final String? nameEn;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;

  Categories({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      id: json['id'],
      name: json['name'],
      nameEn: json['name_en'],
      image: json['image'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'name_en': nameEn,
      'image': image,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
