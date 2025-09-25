import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../controllers/home_controller.dart' as home_controller;
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../global_widgets/custom_image.dart';
import '../../../data/models/restaurant.dart';
import '../../../data/models/category.dart';

class HomeView extends GetView<home_controller.HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() => _getSelectedTabView()),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.accent,
            AppColors.primary.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0.0, 0.6, 1.0],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
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
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.1),
                    AppColors.accent.withOpacity(0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.2),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
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
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.grey.shade50,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15,
              offset: const Offset(0, 5),
              spreadRadius: 2,
            ),
            BoxShadow(
              color: AppColors.primary.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
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

  Widget _getSelectedTabView() {
    switch (controller.currentTabIndex.value) {
      case 0:
        return _buildHomeTab();
      case 1:
        return _buildSearchTab();
      case 2:
        return _buildCartTab();
      case 3:
        return _buildFavoritesTab();
      case 4:
        return _buildProfileTab();
      default:
        return _buildHomeTab();
    }
  }

  Widget _buildHomeTab() {
    return RefreshIndicator(
      onRefresh: () async => controller.refreshData(),
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
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchTab() {
    final searchController = Get.find<home_controller.SearchController>();
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.marginMedium),
      child: Column(
        children: [
          // Search Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: AppDimensions.marginLarge),
            child: Column(
              children: [
                const Text(
                  'Search Restaurants',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.greyDark,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Find your favorite food and restaurants',
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          
          // Search Bar
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: TextField(
              onChanged: searchController.updateSearchText,
              decoration: InputDecoration(
                hintText: 'Search for restaurants, cuisines...',
                prefixIcon: const Icon(Icons.search, color: AppColors.grey),
                suffixIcon: Obx(() => searchController.searchText.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: AppColors.grey),
                        onPressed: searchController.clearSearch,
                      )
                    : const SizedBox.shrink()),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.marginMedium,
                  vertical: AppDimensions.marginMedium,
                ),
              ),
            ),
          ),
          
          const SizedBox(height: AppDimensions.marginLarge),
          
          // Search Results
          Expanded(
            child: Obx(() {
              if (searchController.searchText.isEmpty) {
                return _buildSearchSuggestions();
              } else if (searchController.isSearching.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                );
              } else if (searchController.searchResults.isEmpty) {
                return _buildNoResults();
              } else {
                return _buildSearchResults(searchController.searchResults);
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchSuggestions() {
    final popularSearches = ['Pizza', 'Burger', 'Sushi', 'Chinese', 'Italian', 'Fast Food'];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Popular Searches',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.greyDark,
          ),
        ),
        const SizedBox(height: AppDimensions.marginMedium),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: popularSearches.map((search) => GestureDetector(
            onTap: () => Get.find<home_controller.SearchController>().updateSearchText(search),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.marginMedium,
                vertical: AppDimensions.marginSmall,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.primary.withOpacity(0.3)),
              ),
              child: Text(
                search,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80,
            color: AppColors.grey.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          const Text(
            'No Results Found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.grey,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Try searching with different keywords',
            style: TextStyle(color: AppColors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(List<Restaurant> results) {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final restaurant = results[index];
        return _buildSearchResultCard(restaurant);
      },
    );
  }

  Widget _buildSearchResultCard(Restaurant restaurant) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.marginMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => controller.goToRestaurant(restaurant),
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.marginMedium),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  restaurant.imageUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 60,
                    height: 60,
                    color: Colors.grey[200],
                    child: const Icon(Icons.restaurant, color: AppColors.grey),
                  ),
                ),
              ),
              const SizedBox(width: AppDimensions.marginMedium),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      restaurant.cuisine,
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          restaurant.rating.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(Icons.access_time, color: AppColors.grey, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '${restaurant.deliveryTime} min',
                          style: TextStyle(
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
      ),
    );
  }

  Widget _buildCartTab() {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.marginMedium),
      child: Column(
        children: [
          // Cart Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: AppDimensions.marginLarge),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Cart',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.greyDark,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '3 items added',
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Get.snackbar('Clear Cart', 'All items removed from cart');
                  },
                  child: const Text(
                    'Clear All',
                    style: TextStyle(color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ),

          // Cart Items
          Expanded(
            child: ListView.builder(
              itemCount: 3, // Demo items
              itemBuilder: (context, index) => _buildCartItem(index),
            ),
          ),

          // Cart Summary
          Container(
            padding: const EdgeInsets.all(AppDimensions.marginMedium),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Subtotal',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '\$24.99',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Delivery Fee',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '\$2.99',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const Divider(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$27.98',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimensions.marginMedium),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.snackbar('Order Placed', 'Your order has been placed successfully!');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Proceed to Checkout',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(int index) {
    final items = [
      {'name': 'Margherita Pizza', 'price': '\$12.99', 'quantity': 1},
      {'name': 'Caesar Salad', 'price': '\$8.99', 'quantity': 2},
      {'name': 'Garlic Bread', 'price': '\$3.99', 'quantity': 1},
    ];
    
    final item = items[index];
    
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.marginMedium),
      padding: const EdgeInsets.all(AppDimensions.marginMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 60,
              height: 60,
              color: AppColors.primary.withOpacity(0.1),
              child: const Icon(
                Icons.fastfood,
                color: AppColors.primary,
                size: 30,
              ),
            ),
          ),
          const SizedBox(width: AppDimensions.marginMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item['price'] as String,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.grey.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.remove,
                    size: 16,
                    color: AppColors.greyDark,
                  ),
                ),
              ),
              Text(
                '${item['quantity'] as int}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesTab() {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.marginMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Favorites Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: AppDimensions.marginLarge),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Favorites',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.greyDark,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Your saved restaurants and dishes',
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          // Favorites List
          Expanded(
            child: ListView.builder(
              itemCount: 4, // Demo favorites
              itemBuilder: (context, index) => _buildFavoriteItem(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteItem(int index) {
    final favorites = [
      {
        'name': 'Pizza Palace',
        'cuisine': 'Italian',
        'rating': '4.8',
        'deliveryTime': '25',
        'image': 'https://picsum.photos/200/200?random=${index + 10}',
      },
      {
        'name': 'Burger Hub',
        'cuisine': 'American',
        'rating': '4.6',
        'deliveryTime': '20',
        'image': 'https://picsum.photos/200/200?random=${index + 20}',
      },
      {
        'name': 'Sushi Master',
        'cuisine': 'Japanese',
        'rating': '4.9',
        'deliveryTime': '35',
        'image': 'https://picsum.photos/200/200?random=${index + 30}',
      },
      {
        'name': 'Taco Fiesta',
        'cuisine': 'Mexican',
        'rating': '4.7',
        'deliveryTime': '15',
        'image': 'https://picsum.photos/200/200?random=${index + 40}',
      },
    ];

    final item = favorites[index];

    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.marginMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Get.snackbar('Restaurant', 'Opening ${item['name']}');
        },
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.marginMedium),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  item['image']!,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 80,
                    height: 80,
                    color: AppColors.primary.withOpacity(0.1),
                    child: const Icon(
                      Icons.restaurant,
                      color: AppColors.primary,
                      size: 30,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppDimensions.marginMedium),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['cuisine']!,
                      style: const TextStyle(
                        color: AppColors.grey,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          item['rating']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Icon(Icons.access_time, color: AppColors.grey, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '${item['deliveryTime']} min',
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
              IconButton(
                onPressed: () {
                  Get.snackbar('Removed', '${item['name']} removed from favorites');
                },
                icon: const Icon(
                  Icons.favorite,
                  color: AppColors.error,
                  size: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.marginMedium),
      child: Column(
        children: [
          // Profile Header
          Container(
            padding: const EdgeInsets.all(AppDimensions.marginLarge),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.primaryLight],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 37,
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    backgroundImage: const NetworkImage('https://picsum.photos/200/200?random=profile'),
                    onBackgroundImageError: (exception, stackTrace) {},
                    child: const Icon(
                      Icons.person,
                      size: 40,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(width: AppDimensions.marginMedium),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'John Doe',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'john.doe@example.com',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Premium Member',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppDimensions.marginLarge),

          // Profile Options
          _buildProfileOption(
            Icons.person_outline,
            'Personal Information',
            'Update your personal details',
            () => Get.snackbar('Profile', 'Opening personal information'),
          ),
          _buildProfileOption(
            Icons.location_on_outlined,
            'Delivery Addresses',
            'Manage your delivery addresses',
            () => Get.snackbar('Addresses', 'Opening delivery addresses'),
          ),
          _buildProfileOption(
            Icons.payment_outlined,
            'Payment Methods',
            'Add and manage payment methods',
            () => Get.snackbar('Payment', 'Opening payment methods'),
          ),
          _buildProfileOption(
            Icons.history,
            'Order History',
            'View your past orders',
            () => Get.snackbar('History', 'Opening order history'),
          ),
          _buildProfileOption(
            Icons.notifications_outlined,
            'Notifications',
            'Manage notification preferences',
            () => Get.snackbar('Notifications', 'Opening notification settings'),
          ),
          _buildProfileOption(
            Icons.help_outline,
            'Help & Support',
            'Get help and support',
            () => Get.snackbar('Support', 'Opening help & support'),
          ),
          _buildProfileOption(
            Icons.privacy_tip_outlined,
            'Privacy Policy',
            'Read our privacy policy',
            () => Get.snackbar('Privacy', 'Opening privacy policy'),
          ),
          _buildProfileOption(
            Icons.logout,
            'Logout',
            'Sign out of your account',
            () => _showLogoutDialog(),
            isDestructive: true,
          ),

          const SizedBox(height: AppDimensions.marginLarge),

          // App Version
          Text(
            'YummiEats v1.0.0',
            style: TextStyle(
              color: AppColors.grey.withOpacity(0.7),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOption(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.marginMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: (isDestructive ? AppColors.error : AppColors.primary).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: isDestructive ? AppColors.error : AppColors.primary,
            size: 24,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: isDestructive ? AppColors.error : AppColors.greyDark,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: AppColors.grey,
            fontSize: 14,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: AppColors.grey.withOpacity(0.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.marginMedium,
          vertical: AppDimensions.marginSmall,
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.offAllNamed('/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: const Text('Logout', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Obx(
      () => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: controller.currentTabIndex.value,
        onTap: controller.changeTabIndex,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey,
        backgroundColor: Colors.white,
        elevation: 8,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
