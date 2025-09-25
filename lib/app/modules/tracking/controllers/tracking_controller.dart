import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/order.dart';

class TrackingController extends GetxController {
  final orders = <Order>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadOrders();
  }

  Future<void> loadOrders() async {
    try {
      isLoading.value = true;

      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));

      // Load dummy orders
      orders.value = _generateDummyOrders();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load orders');
    } finally {
      isLoading.value = false;
    }
  }

  List<Order> _generateDummyOrders() {
    return [
      Order(
        id: 'ORD001',
        restaurantName: 'Burger Palace',
        restaurantImage:
            'https://images.unsplash.com/photo-1571091718767-18b5b1457add',
        items: ['1x Classic Beef Burger', '1x Crispy Fries'],
        total: 17.98,
        status: OrderStatus.onTheWay,
        orderTime: DateTime.now().subtract(const Duration(minutes: 25)),
        estimatedDeliveryTime: DateTime.now().add(const Duration(minutes: 10)),
        deliveryAddress: '123 Main Street, Downtown',
        driverName: 'John Doe',
        driverPhone: '+1234567890',
        driverImage:
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d',
      ),
      Order(
        id: 'ORD002',
        restaurantName: 'Pizza Corner',
        restaurantImage:
            'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b',
        items: ['1x Margherita Pizza (Large)', '1x Garlic Bread'],
        total: 24.99,
        status: OrderStatus.delivered,
        orderTime: DateTime.now().subtract(const Duration(hours: 2)),
        estimatedDeliveryTime:
            DateTime.now().subtract(const Duration(minutes: 90)),
        deliveryAddress: '123 Main Street, Downtown',
      ),
    ];
  }

  void refreshOrders() {
    loadOrders();
  }

  void trackOrder(String orderId) {
    Get.toNamed('/order-details', arguments: orderId);
  }

  void reorderItems(Order order) {
    Get.snackbar(
      'Reorder',
      'Items from ${order.restaurantName} have been added to your cart',
    );
  }

  void rateOrder(Order order) {
    Get.dialog(
      AlertDialog(
        title: const Text('Rate your order'),
        content: const Text('How was your experience?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              Get.snackbar('Thank you', 'Your rating has been submitted');
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  String getStatusText(OrderStatus status) {
    switch (status) {
      case OrderStatus.placed:
        return 'Order Placed';
      case OrderStatus.confirmed:
        return 'Order Confirmed';
      case OrderStatus.preparing:
        return 'Preparing Your Food';
      case OrderStatus.ready:
        return 'Ready for Pickup';
      case OrderStatus.pickedUp:
        return 'Picked Up';
      case OrderStatus.onTheWay:
        return 'On the Way';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  Color getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.placed:
      case OrderStatus.confirmed:
        return const Color(0xFF2196F3); // Blue
      case OrderStatus.preparing:
      case OrderStatus.ready:
        return const Color(0xFFFF9800); // Orange
      case OrderStatus.pickedUp:
      case OrderStatus.onTheWay:
        return const Color(0xFF9C27B0); // Purple
      case OrderStatus.delivered:
        return const Color(0xFF4CAF50); // Green
      case OrderStatus.cancelled:
        return const Color(0xFFF44336); // Red
    }
  }
}
