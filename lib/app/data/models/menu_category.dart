import 'food_item.dart';

class MenuCategory {
  final String id;
  final String name;
  final String description;
  final List<FoodItem> items;
  final bool isPopular;

  MenuCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.items,
    this.isPopular = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'items': items.map((item) => item.toJson()).toList(),
        'isPopular': isPopular,
      };

  factory MenuCategory.fromJson(Map<String, dynamic> json) => MenuCategory(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        items: List<FoodItem>.from(
          json['items']?.map((item) => FoodItem.fromJson(item)) ?? [],
        ),
        isPopular: json['isPopular'] ?? false,
      );

  MenuCategory copyWith({
    String? id,
    String? name,
    String? description,
    List<FoodItem>? items,
    bool? isPopular,
  }) {
    return MenuCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      items: items ?? this.items,
      isPopular: isPopular ?? this.isPopular,
    );
  }
}
