class User {
  final String id;
  final String token;
  final String name;
  final String email;
  final String imageUrl;

  User({
    required this.id,
    required this.token,
    required this.name,
    required this.email,
    required this.imageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      token: json['token'],
      name: json['name'],
      email: json['email'],
      imageUrl: json['imageUrl'],
    );
  }
}
