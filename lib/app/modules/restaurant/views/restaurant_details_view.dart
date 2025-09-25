import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../controllers/restaurant_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/models/food_item.dart';

class RestaurantDetailsView extends GetView<RestaurantController> {
  const RestaurantDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.restaurant.value == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return _buildContent();
      }),
      floatingActionButton: Obx(() => controller.cartController.totalItems > 0
          ? FloatingActionButton.extended(
              onPressed: () => Get.toNamed('/cart'),
              backgroundColor: AppColors.primary,
              icon: const Icon(Icons.shopping_cart),
              label: Text('Cart (${controller.cartController.totalItems})'),
            )
          : const SizedBox.shrink()),
    );
  }

  Widget _buildContent() {
    final restaurant = controller.restaurant.value!;

    return CustomScrollView(
      slivers: [
        // App Bar with Image
        SliverAppBar(
          expandedHeight: 250,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(restaurant.coverImageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black54],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurant.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        restaurant.cuisine,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Obx(() => IconButton(
                  icon: Icon(
                    controller.isFavorite.value
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color:
                        controller.isFavorite.value ? Colors.red : Colors.white,
                  ),
                  onPressed: controller.toggleFavorite,
                )),
          ],
        ),

        // Restaurant Info
        SliverToBoxAdapter(
          child: _buildRestaurantInfo(restaurant),
        ),

        // Category Filter
        SliverToBoxAdapter(
          child: _buildCategoryFilter(),
        ),

        // Menu Items
        SliverPadding(
          padding: const EdgeInsets.all(AppDimensions.paddingMedium),
          sliver: Obx(() => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final items = controller.filteredMenuItems;
                    final item = items[index];
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: _buildMenuItem(item),
                        ),
                      ),
                    );
                  },
                  childCount: controller.filteredMenuItems.length,
                ),
              )),
        ),
      ],
    );
  }

  Widget _buildRestaurantInfo(restaurant) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rating and Delivery Info
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.success,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      restaurant.rating.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Icon(Icons.access_time, size: 16, color: AppColors.grey),
              const SizedBox(width: 4),
              Text('${restaurant.deliveryTime} min'),
              const SizedBox(width: 16),
              Icon(Icons.delivery_dining, size: 16, color: AppColors.grey),
              const SizedBox(width: 4),
              Text('\$${restaurant.deliveryFee.toStringAsFixed(2)}'),
            ],
          ),

          const SizedBox(height: AppDimensions.marginMedium),

          // Description
          Text(
            restaurant.description,
            style: TextStyle(
              color: AppColors.grey,
              fontSize: 14,
              height: 1.4,
            ),
          ),

          const SizedBox(height: AppDimensions.marginMedium),

          // Address
          Row(
            children: [
              Icon(Icons.location_on, size: 16, color: AppColors.grey),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  restaurant.address,
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      height: 50,
      color: AppColors.background,
      child: Obx(() => ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingMedium),
            itemCount: controller.categories.length,
            itemBuilder: (context, index) {
              final category = controller.categories[index];
              final isSelected = controller.selectedCategory.value == category;

              return Container(
                margin: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                child: FilterChip(
                  label: Text(category),
                  selected: isSelected,
                  onSelected: (_) => controller.selectCategory(category),
                  selectedColor: AppColors.primary.withOpacity(0.2),
                  checkmarkColor: AppColors.primary,
                ),
              );
            },
          )),
    );
  }

  Widget _buildMenuItem(FoodItem item) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppDimensions.marginMedium),
      child: InkWell(
        onTap: () => controller.addToCart(item),
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingMedium),
          child: Row(
            children: [
              // Food Image
              ClipRRect(
                borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(item.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: AppDimensions.marginMedium),

              // Food Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (item.isVegetarian)
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.success),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: const Icon(
                              Icons.circle,
                              color: AppColors.success,
                              size: 8,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.description,
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\$${item.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                            if (item.rating > 0)
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    size: 12,
                                    color: AppColors.accent,
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    item.rating.toString(),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(
                                AppDimensions.radiusSmall),
                          ),
                          child: const Text(
                            'ADD',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
