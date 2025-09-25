import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../controllers/restaurant_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../global_widgets/custom_image.dart';
import '../../../global_widgets/custom_button.dart';
import '../../../global_widgets/custom_textfield.dart';
import '../../../data/models/food_item.dart';

class FoodDetailsView extends GetView<FoodDetailsController> {
  const FoodDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.foodItem.value == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return _buildContent();
      }),
      bottomNavigationBar: _buildAddToCartSection(),
    );
  }

  Widget _buildContent() {
    final food = controller.foodItem.value!;

    return CustomScrollView(
      slivers: [
        // App Bar with Image
        SliverAppBar(
          expandedHeight: 300,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: CustomNetworkImage(
              imageUrl: food.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),

        SliverPadding(
          padding: const EdgeInsets.all(AppDimensions.paddingMedium),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              AnimationLimiter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 375),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(child: widget),
                    ),
                    children: [
                      _buildFoodInfo(food),
                      const SizedBox(height: AppDimensions.marginLarge),
                      _buildVariants(),
                      const SizedBox(height: AppDimensions.marginLarge),
                      _buildAddOns(),
                      const SizedBox(height: AppDimensions.marginLarge),
                      _buildQuantitySelector(),
                      const SizedBox(height: AppDimensions.marginLarge),
                      _buildSpecialInstructions(),
                      const SizedBox(height: 100), // Space for bottom bar
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildFoodInfo(FoodItem food) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                food.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (food.isVegetarian)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.success),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(
                  Icons.eco,
                  color: AppColors.success,
                  size: 16,
                ),
              ),
          ],
        ),

        const SizedBox(height: 8),

        Text(
          food.description,
          style: TextStyle(
            color: AppColors.grey,
            fontSize: 16,
            height: 1.4,
          ),
        ),

        const SizedBox(height: AppDimensions.marginMedium),

        // Rating and prep time
        Row(
          children: [
            if (food.rating > 0) ...[
              const Icon(Icons.star, color: AppColors.accent, size: 16),
              const SizedBox(width: 4),
              Text('${food.rating} (${food.reviewCount} reviews)'),
              const SizedBox(width: 16),
            ],
            const Icon(Icons.access_time, color: AppColors.grey, size: 16),
            const SizedBox(width: 4),
            Text('${food.preparationTime} min'),
          ],
        ),

        if (food.ingredients.isNotEmpty) ...[
          const SizedBox(height: AppDimensions.marginMedium),
          const Text(
            'Ingredients',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: food.ingredients.map((ingredient) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusRound),
                ),
                child: Text(
                  ingredient,
                  style: const TextStyle(fontSize: 12),
                ),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }

  Widget _buildVariants() {
    final food = controller.foodItem.value!;
    if (food.variants.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Size Options',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppDimensions.marginMedium),
        Obx(() => Column(
              children: food.variants.map((variant) {
                final isSelected =
                    controller.selectedVariant.value?.id == variant.id;
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: InkWell(
                    onTap: () => controller.selectVariant(variant),
                    child: Container(
                      padding:
                          const EdgeInsets.all(AppDimensions.paddingMedium),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary.withOpacity(0.1)
                            : AppColors.background,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.greyLight,
                        ),
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radiusMedium),
                      ),
                      child: Row(
                        children: [
                          Radio<String>(
                            value: variant.id,
                            groupValue: controller.selectedVariant.value?.id,
                            onChanged: (_) => controller.selectVariant(variant),
                            activeColor: AppColors.primary,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  variant.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  variant.size,
                                  style: TextStyle(
                                    color: AppColors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '\$${variant.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            )),
      ],
    );
  }

  Widget _buildAddOns() {
    final food = controller.foodItem.value!;
    if (food.addOns.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Add-Ons',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppDimensions.marginMedium),
        Obx(() => Column(
              children: food.addOns.map((addOn) {
                final isSelected = controller.selectedAddOns
                    .any((selected) => selected.id == addOn.id);

                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: InkWell(
                    onTap: () => controller.toggleAddOn(addOn),
                    child: Container(
                      padding:
                          const EdgeInsets.all(AppDimensions.paddingMedium),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary.withOpacity(0.1)
                            : AppColors.background,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.greyLight,
                        ),
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radiusMedium),
                      ),
                      child: Row(
                        children: [
                          Checkbox(
                            value: isSelected,
                            onChanged: (_) => controller.toggleAddOn(addOn),
                            activeColor: AppColors.primary,
                          ),
                          Expanded(
                            child: Text(
                              addOn.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            '+\$${addOn.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            )),
      ],
    );
  }

  Widget _buildQuantitySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quantity',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppDimensions.marginMedium),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => controller
                        .updateQuantity(controller.quantity.value - 1),
                  ),
                  Obx(() => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          controller.quantity.value.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => controller
                        .updateQuantity(controller.quantity.value + 1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSpecialInstructions() {
    return Column(
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
        CustomTextField(
          hintText: 'Any special requests for this item?',
          maxLines: 3,
          onChanged: controller.updateSpecialInstructions,
        ),
      ],
    );
  }

  Widget _buildAddToCartSection() {
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
                  'Add to Cart • \$${controller.totalPrice.value.toStringAsFixed(2)}',
              onPressed: controller.addToCart,
              width: double.infinity,
            )),
      ),
    );
  }
}
