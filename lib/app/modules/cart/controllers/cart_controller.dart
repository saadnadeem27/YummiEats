import 'package:get/get.dart';
import '../../../data/models/cart_item.dart';
import '../../../data/models/food_item.dart';

class CartController extends GetxController {
  final cartItems = <CartItem>[].obs;
  final isLoading = false.obs;

  double get subtotal {
    return cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  double get deliveryFee => 3.99;
  double get tax => subtotal * 0.1; // 10% tax
  double get total => subtotal + deliveryFee + tax;

  int get totalItems {
    return cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  bool get isEmpty => cartItems.isEmpty;

  void addToCart(
    FoodItem foodItem, {
    int quantity = 1,
    List<FoodAddOn> selectedAddOns = const [],
    FoodVariant? selectedVariant,
    String? specialInstructions,
  }) {
    // Calculate total price including add-ons and variant
    double itemPrice = foodItem.price;
    if (selectedVariant != null) {
      itemPrice = selectedVariant.price;
    }

    double addOnsPrice =
        selectedAddOns.fold(0.0, (sum, addOn) => sum + addOn.price);
    double totalPrice = (itemPrice + addOnsPrice) * quantity;

    // Check if item already exists in cart
    final existingItemIndex = cartItems.indexWhere((item) =>
        item.foodItem.id == foodItem.id &&
        _areAddOnsSame(item.selectedAddOns, selectedAddOns) &&
        item.selectedVariant?.id == selectedVariant?.id);

    if (existingItemIndex != -1) {
      // Update existing item
      final existingItem = cartItems[existingItemIndex];
      final newQuantity = existingItem.quantity + quantity;
      final newTotalPrice = (itemPrice + addOnsPrice) * newQuantity;

      cartItems[existingItemIndex] = existingItem.copyWith(
        quantity: newQuantity,
        totalPrice: newTotalPrice,
      );
    } else {
      // Add new item
      final cartItem = CartItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        foodItem: foodItem,
        quantity: quantity,
        totalPrice: totalPrice,
        selectedAddOns: selectedAddOns,
        selectedVariant: selectedVariant,
        specialInstructions: specialInstructions,
      );
      cartItems.add(cartItem);
    }

    Get.snackbar(
      'Added to Cart',
      '${foodItem.name} has been added to your cart',
      duration: const Duration(seconds: 2),
    );
  }

  bool _areAddOnsSame(List<FoodAddOn> addOns1, List<FoodAddOn> addOns2) {
    if (addOns1.length != addOns2.length) return false;

    final ids1 = addOns1.map((e) => e.id).toSet();
    final ids2 = addOns2.map((e) => e.id).toSet();

    return ids1.difference(ids2).isEmpty && ids2.difference(ids1).isEmpty;
  }

  void updateQuantity(String cartItemId, int newQuantity) {
    final index = cartItems.indexWhere((item) => item.id == cartItemId);
    if (index != -1) {
      if (newQuantity <= 0) {
        removeFromCart(cartItemId);
      } else {
        final item = cartItems[index];
        final unitPrice = item.totalPrice / item.quantity;
        cartItems[index] = item.copyWith(
          quantity: newQuantity,
          totalPrice: unitPrice * newQuantity,
        );
      }
    }
  }

  void removeFromCart(String cartItemId) {
    cartItems.removeWhere((item) => item.id == cartItemId);
  }

  void clearCart() {
    cartItems.clear();
  }

  Future<void> checkout() async {
    if (cartItems.isEmpty) {
      Get.snackbar('Error', 'Your cart is empty');
      return;
    }

    try {
      isLoading.value = true;

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Navigate to order confirmation
      Get.toNamed('/order-confirmation', arguments: {
        'orderId': 'ORD${DateTime.now().millisecondsSinceEpoch}',
        'items': cartItems.toList(),
        'total': total,
      });

      // Clear cart after successful order
      clearCart();

      Get.snackbar(
        'Order Placed',
        'Your order has been placed successfully!',
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to place order. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }
}
