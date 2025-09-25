import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../controllers/cart_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_strings.dart';
import '../../../global_widgets/custom_button.dart';
import '../../../global_widgets/custom_image.dart';
import '../../../data/models/cart_item.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.cart),
        actions: [
          Obx(() => controller.cartItems.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: _showClearCartDialog,
                )
              : const SizedBox.shrink()),
        ],
      ),
      body: Obx(() {
        if (controller.isEmpty) {
          return _buildEmptyCart();
        }
        return _buildCartContent();
      }),
      bottomNavigationBar: Obx(() => controller.isEmpty
          ? const SizedBox.shrink()
          : _buildCheckoutSection()),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 100,
            color: AppColors.greyLight,
          ),
          const SizedBox(height: AppDimensions.marginMedium),
          Text(
            AppStrings.emptyCart,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.grey,
            ),
          ),
          const SizedBox(height: AppDimensions.marginSmall),
          Text(
            'Add items to get started',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.grey,
            ),
          ),
          const SizedBox(height: AppDimensions.marginLarge),
          CustomButton(
            text: 'Browse Menu',
            onPressed: () => Get.back(),
            width: 200,
          ),
        ],
      ),
    );
  }

  Widget _buildCartContent() {
    return Column(
      children: [
        Expanded(
          child: AnimationLimiter(
            child: ListView.builder(
              padding: const EdgeInsets.all(AppDimensions.paddingMedium),
              itemCount: controller.cartItems.length,
              itemBuilder: (context, index) {
                final item = controller.cartItems[index];
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: _buildCartItem(item, index),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        _buildOrderSummary(),
      ],
    );
  }

  Widget _buildCartItem(CartItem item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.marginMedium),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        child: Row(
          children: [
            // Food Image
            CustomNetworkImage(
              imageUrl: item.foodItem.imageUrl,
              width: 80,
              height: 80,
              borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
            ),
            const SizedBox(width: AppDimensions.marginMedium),

            // Food Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.foodItem.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  // Variant
                  if (item.selectedVariant != null)
                    Text(
                      'Size: ${item.selectedVariant!.size}',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.grey,
                      ),
                    ),

                  // Add-ons
                  if (item.selectedAddOns.isNotEmpty)
                    Text(
                      'Add-ons: ${item.selectedAddOns.map((e) => e.name).join(', ')}',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.grey,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                  const SizedBox(height: 8),

                  // Price and Quantity Controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${item.totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),

                      // Quantity Controls
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius:
                              BorderRadius.circular(AppDimensions.radiusSmall),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () => controller.updateQuantity(
                                item.id,
                                item.quantity - 1,
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 32,
                                minHeight: 32,
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                item.quantity.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () => controller.updateQuantity(
                                item.id,
                                item.quantity + 1,
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 32,
                                minHeight: 32,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Delete Button
            IconButton(
              icon: const Icon(Icons.delete_outline, color: AppColors.error),
              onPressed: () => _showRemoveItemDialog(item),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.radiusLarge),
          topRight: Radius.circular(AppDimensions.radiusLarge),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 8,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSummaryRow(AppStrings.subtotal, controller.subtotal),
          _buildSummaryRow(AppStrings.deliveryFee, controller.deliveryFee),
          _buildSummaryRow(AppStrings.tax, controller.tax),
          const Divider(),
          _buildSummaryRow(
            AppStrings.total,
            controller.total,
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? AppColors.black : AppColors.grey,
            ),
          ),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? AppColors.primary : AppColors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutSection() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: const BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 8,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Obx(() => CustomButton(
              text:
                  '${AppStrings.continueToCheckout} (${controller.totalItems} items)',
              onPressed: controller.checkout,
              isLoading: controller.isLoading.value,
              width: double.infinity,
            )),
      ),
    );
  }

  void _showClearCartDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Clear Cart'),
        content: const Text(
            'Are you sure you want to remove all items from your cart?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () {
              controller.clearCart();
              Get.back();
            },
            child: const Text(
              'Clear',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  void _showRemoveItemDialog(CartItem item) {
    Get.dialog(
      AlertDialog(
        title: const Text('Remove Item'),
        content: Text('Remove ${item.foodItem.name} from your cart?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () {
              controller.removeFromCart(item.id);
              Get.back();
            },
            child: const Text(
              'Remove',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
