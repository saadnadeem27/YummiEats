import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../controllers/cart_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_strings.dart';
import '../../../global_widgets/custom_button.dart';

class CheckoutView extends GetView<CartController> {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.checkout),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        child: AnimationLimiter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 375),
              childAnimationBuilder: (widget) => SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(child: widget),
              ),
              children: [
                _buildDeliveryAddress(),
                const SizedBox(height: AppDimensions.marginLarge),
                _buildPaymentMethod(),
                const SizedBox(height: AppDimensions.marginLarge),
                _buildOrderSummary(),
                const SizedBox(height: AppDimensions.marginLarge),
                _buildSpecialInstructions(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildPlaceOrderButton(),
    );
  }

  Widget _buildDeliveryAddress() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Delivery Address',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppDimensions.marginMedium),
            Row(
              children: [
                const Icon(Icons.location_on, color: AppColors.primary),
                const SizedBox(width: AppDimensions.marginSmall),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Home',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '123 Main Street, Downtown, City 12345',
                        style: TextStyle(
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to address selection
                  },
                  child: const Text('Change'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethod() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Payment Method',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppDimensions.marginMedium),
            _buildPaymentOption(
              icon: Icons.credit_card,
              title: 'Credit Card',
              subtitle: '**** **** **** 1234',
              isSelected: true,
            ),
            _buildPaymentOption(
              icon: Icons.account_balance_wallet,
              title: 'Digital Wallet',
              subtitle: 'PayPal',
              isSelected: false,
            ),
            _buildPaymentOption(
              icon: Icons.money,
              title: 'Cash on Delivery',
              subtitle: 'Pay when you receive',
              isSelected: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isSelected,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Radio<bool>(
        value: true,
        groupValue: isSelected,
        onChanged: (value) {
          // Handle payment method selection
        },
        activeColor: AppColors.primary,
      ),
      onTap: () {
        // Handle payment method selection
      },
    );
  }

  Widget _buildOrderSummary() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppDimensions.marginMedium),
            Obx(() => Column(
                  children: controller.cartItems.map((item) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '${item.quantity}x ${item.foodItem.name}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          Text(
                            '\$${item.totalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                )),
            const Divider(),
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

  Widget _buildSpecialInstructions() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Special Instructions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppDimensions.marginMedium),
            TextField(
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Add any special instructions for your order...',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceOrderButton() {
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
              text: 'Place Order • \$${controller.total.toStringAsFixed(2)}',
              onPressed: controller.checkout,
              isLoading: controller.isLoading.value,
              width: double.infinity,
            )),
      ),
    );
  }
}
