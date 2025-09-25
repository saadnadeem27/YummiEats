import 'food_item.dart';

class CartItem {
  final String id;
  final FoodItem foodItem;
  final int quantity;
  final double totalPrice;
  final List<FoodAddOn> selectedAddOns;
  final FoodVariant? selectedVariant;
  final String? specialInstructions;

  CartItem({
    required this.id,
    required this.foodItem,
    required this.quantity,
    required this.totalPrice,
    this.selectedAddOns = const [],
    this.selectedVariant,
    this.specialInstructions,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      foodItem: FoodItem.fromJson(json['foodItem']),
      quantity: json['quantity'],
      totalPrice: (json['totalPrice'] as num).toDouble(),
      selectedAddOns: (json['selectedAddOns'] as List<dynamic>?)
              ?.map((e) => FoodAddOn.fromJson(e))
              .toList() ??
          [],
      selectedVariant: json['selectedVariant'] != null
          ? FoodVariant.fromJson(json['selectedVariant'])
          : null,
      specialInstructions: json['specialInstructions'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'foodItem': foodItem.toJson(),
      'quantity': quantity,
      'totalPrice': totalPrice,
      'selectedAddOns': selectedAddOns.map((e) => e.toJson()).toList(),
      'selectedVariant': selectedVariant?.toJson(),
      'specialInstructions': specialInstructions,
    };
  }

  CartItem copyWith({
    String? id,
    FoodItem? foodItem,
    int? quantity,
    double? totalPrice,
    List<FoodAddOn>? selectedAddOns,
    FoodVariant? selectedVariant,
    String? specialInstructions,
  }) {
    return CartItem(
      id: id ?? this.id,
      foodItem: foodItem ?? this.foodItem,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
      selectedAddOns: selectedAddOns ?? this.selectedAddOns,
      selectedVariant: selectedVariant ?? this.selectedVariant,
      specialInstructions: specialInstructions ?? this.specialInstructions,
    );
  }
}
