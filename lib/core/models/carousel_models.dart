class Carousel {
  final int id;
  final String title;
  final String description;
  final String imagePath;
  final int isActive;
  final String createdAt;
  final String updatedAt;

  Carousel({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Carousel.fromJson(Map<String, dynamic> json) {
    return Carousel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imagePath: json['image_path'],
      isActive: json['is_active'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image_path': imagePath,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
