class Restaurant {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String coverImageUrl;
  final double rating;
  final int reviewCount;
  final String cuisine;
  final int deliveryTime;
  final double deliveryFee;
  final bool isOpen;
  final String address;
  final double latitude;
  final double longitude;
  final List<String> categories;
  final String priceRange;
  final bool isFavorite;
  final bool hasDiscount;
  final int? discountPercentage;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.coverImageUrl,
    required this.rating,
    required this.reviewCount,
    required this.cuisine,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.isOpen,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.categories,
    required this.priceRange,
    this.isFavorite = false,
    this.hasDiscount = false,
    this.discountPercentage,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      coverImageUrl: json['coverImageUrl'],
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'],
      cuisine: json['cuisine'],
      deliveryTime: json['deliveryTime'],
      deliveryFee: (json['deliveryFee'] as num).toDouble(),
      isOpen: json['isOpen'],
      address: json['address'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      categories: List<String>.from(json['categories']),
      priceRange: json['priceRange'],
      isFavorite: json['isFavorite'] ?? false,
      hasDiscount: json['hasDiscount'] ?? false,
      discountPercentage: json['discountPercentage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'coverImageUrl': coverImageUrl,
      'rating': rating,
      'reviewCount': reviewCount,
      'cuisine': cuisine,
      'deliveryTime': deliveryTime,
      'deliveryFee': deliveryFee,
      'isOpen': isOpen,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'categories': categories,
      'priceRange': priceRange,
      'isFavorite': isFavorite,
      'hasDiscount': hasDiscount,
      'discountPercentage': discountPercentage,
    };
  }

  Restaurant copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    String? coverImageUrl,
    double? rating,
    int? reviewCount,
    String? cuisine,
    int? deliveryTime,
    double? deliveryFee,
    bool? isOpen,
    String? address,
    double? latitude,
    double? longitude,
    List<String>? categories,
    String? priceRange,
    bool? isFavorite,
    bool? hasDiscount,
    int? discountPercentage,
  }) {
    return Restaurant(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      cuisine: cuisine ?? this.cuisine,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      isOpen: isOpen ?? this.isOpen,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      categories: categories ?? this.categories,
      priceRange: priceRange ?? this.priceRange,
      isFavorite: isFavorite ?? this.isFavorite,
      hasDiscount: hasDiscount ?? this.hasDiscount,
      discountPercentage: discountPercentage ?? this.discountPercentage,
    );
  }
}
