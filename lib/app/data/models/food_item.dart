class FoodItem {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final String category;
  final bool isVegetarian;
  final bool isVegan;
  final bool isGlutenFree;
  final bool isSpicy;
  final double rating;
  final int reviewCount;
  final List<String> ingredients;
  final List<FoodAddOn> addOns;
  final List<FoodVariant> variants;
  final bool isPopular;
  final bool isAvailable;
  final int preparationTime;

  FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.category,
    this.isVegetarian = false,
    this.isVegan = false,
    this.isGlutenFree = false,
    this.isSpicy = false,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.ingredients = const [],
    this.addOns = const [],
    this.variants = const [],
    this.isPopular = false,
    this.isAvailable = true,
    this.preparationTime = 15,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      price: (json['price'] as num).toDouble(),
      category: json['category'],
      isVegetarian: json['isVegetarian'] ?? false,
      isVegan: json['isVegan'] ?? false,
      isGlutenFree: json['isGlutenFree'] ?? false,
      isSpicy: json['isSpicy'] ?? false,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: json['reviewCount'] ?? 0,
      ingredients: List<String>.from(json['ingredients'] ?? []),
      addOns: (json['addOns'] as List<dynamic>?)
              ?.map((e) => FoodAddOn.fromJson(e))
              .toList() ??
          [],
      variants: (json['variants'] as List<dynamic>?)
              ?.map((e) => FoodVariant.fromJson(e))
              .toList() ??
          [],
      isPopular: json['isPopular'] ?? false,
      isAvailable: json['isAvailable'] ?? true,
      preparationTime: json['preparationTime'] ?? 15,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'category': category,
      'isVegetarian': isVegetarian,
      'isVegan': isVegan,
      'isGlutenFree': isGlutenFree,
      'isSpicy': isSpicy,
      'rating': rating,
      'reviewCount': reviewCount,
      'ingredients': ingredients,
      'addOns': addOns.map((e) => e.toJson()).toList(),
      'variants': variants.map((e) => e.toJson()).toList(),
      'isPopular': isPopular,
      'isAvailable': isAvailable,
      'preparationTime': preparationTime,
    };
  }
}

class FoodAddOn {
  final String id;
  final String name;
  final double price;
  final bool isSelected;

  FoodAddOn({
    required this.id,
    required this.name,
    required this.price,
    this.isSelected = false,
  });

  factory FoodAddOn.fromJson(Map<String, dynamic> json) {
    return FoodAddOn(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      isSelected: json['isSelected'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'isSelected': isSelected,
    };
  }

  FoodAddOn copyWith({
    String? id,
    String? name,
    double? price,
    bool? isSelected,
  }) {
    return FoodAddOn(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

class FoodVariant {
  final String id;
  final String name;
  final double price;
  final String size;
  final bool isSelected;

  FoodVariant({
    required this.id,
    required this.name,
    required this.price,
    required this.size,
    this.isSelected = false,
  });

  factory FoodVariant.fromJson(Map<String, dynamic> json) {
    return FoodVariant(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      size: json['size'],
      isSelected: json['isSelected'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'size': size,
      'isSelected': isSelected,
    };
  }

  FoodVariant copyWith({
    String? id,
    String? name,
    double? price,
    String? size,
    bool? isSelected,
  }) {
    return FoodVariant(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      size: size ?? this.size,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
