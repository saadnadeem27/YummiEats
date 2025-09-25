class Category {
  final String id;
  final String name;
  final String imageUrl;
  final String iconUrl;
  final String description;
  final int itemCount;
  final bool isPopular;

  Category({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.iconUrl,
    required this.description,
    this.itemCount = 0,
    this.isPopular = false,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      iconUrl: json['iconUrl'],
      description: json['description'],
      itemCount: json['itemCount'] ?? 0,
      isPopular: json['isPopular'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'iconUrl': iconUrl,
      'description': description,
      'itemCount': itemCount,
      'isPopular': isPopular,
    };
  }
}
