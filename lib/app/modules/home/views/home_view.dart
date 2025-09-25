import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../controllers/home_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../global_widgets/custom_image.dart';
import '../../../data/models/restaurant.dart';
import '../../../data/models/category.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: controller.refreshData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                _buildSearchBar(),
                _buildCategories(),
                _buildPopularRestaurants(),
                _buildNearbyRestaurants(),
                const SizedBox(height: AppDimensions.marginXLarge),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: const BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppDimensions.radiusLarge),
          bottomRight: Radius.circular(AppDimensions.radiusLarge),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.getGreeting(),
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Text(
                    'John Doe', // This would come from user data
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white30,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.notifications_outlined,
                  color: AppColors.white,
                  size: AppDimensions.iconLarge,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.marginMedium),
          const Text(
            'What would you like to eat today?',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMedium,
          vertical: AppDimensions.paddingSmall,
        ),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          border: Border.all(color: AppColors.greyLight),
        ),
        child: InkWell(
          onTap: () => controller.changeTabIndex(1), // Go to search tab
          child: const Row(
            children: [
              Icon(Icons.search, color: AppColors.grey),
              SizedBox(width: AppDimensions.paddingMedium),
              Text(
                'Search restaurants or cuisines...',
                style: TextStyle(
                  color: AppColors.grey,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingMedium,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {}, // Navigate to all categories
                child: const Text('See All'),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppDimensions.marginMedium),
        Obx(() => SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingMedium,
                ),
                itemCount: controller.categories.length,
                itemBuilder: (context, index) {
                  final category = controller.categories[index];
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      horizontalOffset: 50.0,
                      child: FadeInAnimation(
                        child: _buildCategoryItem(category),
                      ),
                    ),
                  );
                },
              ),
            )),
      ],
    );
  }

  Widget _buildCategoryItem(Category category) {
    return GestureDetector(
      onTap: () => controller.goToCategory(category),
      child: Container(
        width: 80,
        margin: const EdgeInsets.only(right: AppDimensions.marginMedium),
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                gradient: AppColors.cardGradient,
                borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.shadowLight,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  category.iconUrl,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.marginSmall),
            Text(
              category.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularRestaurants() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingMedium),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Popular Restaurants',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {}, // Navigate to all restaurants
                child: const Text('See All'),
              ),
            ],
          ),
        ),
        Obx(() => SizedBox(
              height: 280,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingMedium,
                ),
                itemCount: controller.popularRestaurants.length,
                itemBuilder: (context, index) {
                  final restaurant = controller.popularRestaurants[index];
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      horizontalOffset: 50.0,
                      child: FadeInAnimation(
                        child: _buildRestaurantCard(restaurant),
                      ),
                    ),
                  );
                },
              ),
            )),
      ],
    );
  }

  Widget _buildNearbyRestaurants() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingMedium),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Nearby Restaurants',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {}, // Navigate to all nearby restaurants
                child: const Text('See All'),
              ),
            ],
          ),
        ),
        Obx(() => ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingMedium,
              ),
              itemCount: controller.nearbyRestaurants.length,
              itemBuilder: (context, index) {
                final restaurant = controller.nearbyRestaurants[index];
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: _buildRestaurantListItem(restaurant),
                    ),
                  ),
                );
              },
            )),
      ],
    );
  }

  Widget _buildRestaurantCard(Restaurant restaurant) {
    return GestureDetector(
      onTap: () => controller.goToRestaurant(restaurant),
      child: Container(
        width: 280,
        margin: const EdgeInsets.only(right: AppDimensions.marginMedium),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CustomNetworkImage(
                  imageUrl: restaurant.imageUrl,
                  width: double.infinity,
                  height: 160,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AppDimensions.radiusMedium),
                    topRight: Radius.circular(AppDimensions.radiusMedium),
                  ),
                ),
                if (restaurant.hasDiscount)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${restaurant.discountPercentage}% OFF',
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      restaurant.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: AppColors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    restaurant.cuisine,
                    style: const TextStyle(
                      color: AppColors.grey,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: AppColors.accent,
                        size: 16,
                      ),
                      Text(
                        ' ${restaurant.rating}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.delivery_dining,
                        color: AppColors.grey,
                        size: 16,
                      ),
                      Text(
                        ' ${restaurant.deliveryTime} min',
                        style: const TextStyle(
                          color: AppColors.grey,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        ' • \$${restaurant.deliveryFee.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: AppColors.grey,
                          fontSize: 14,
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
    );
  }

  Widget _buildRestaurantListItem(Restaurant restaurant) {
    return GestureDetector(
      onTap: () => controller.goToRestaurant(restaurant),
      child: Container(
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
        child: Row(
          children: [
            Stack(
              children: [
                CustomNetworkImage(
                  imageUrl: restaurant.imageUrl,
                  width: 100,
                  height: 100,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AppDimensions.radiusMedium),
                    bottomLeft: Radius.circular(AppDimensions.radiusMedium),
                  ),
                ),
                if (restaurant.hasDiscount)
                  Positioned(
                    top: 4,
                    left: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${restaurant.discountPercentage}% OFF',
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      restaurant.cuisine,
                      style: const TextStyle(
                        color: AppColors.grey,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: AppColors.accent,
                          size: 16,
                        ),
                        Text(
                          ' ${restaurant.rating}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.delivery_dining,
                          color: AppColors.grey,
                          size: 16,
                        ),
                        Text(
                          ' ${restaurant.deliveryTime} min',
                          style: const TextStyle(
                            color: AppColors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingMedium),
              child: Icon(
                restaurant.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: restaurant.isFavorite ? AppColors.error : AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
