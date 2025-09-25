import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import 'home_view.dart';
import '../controllers/home_controller.dart' as home;
import '../../cart/views/cart_view.dart';
import '../../tracking/views/tracking_view.dart';
import '../../profile/views/profile_view.dart';

class MainView extends GetView<HomeController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const HomeView(),
      const SearchView(),
      const CartView(),
      const TrackingView(),
      const ProfileView(),
    ];

    final List<BottomNavigationBarItem> navItems = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        activeIcon: Icon(Icons.home),
        label: 'Home',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.search_outlined),
        activeIcon: Icon(Icons.search),
        label: 'Search',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart_outlined),
        activeIcon: Icon(Icons.shopping_cart),
        label: 'Cart',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.delivery_dining_outlined),
        activeIcon: Icon(Icons.delivery_dining),
        label: 'Orders',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.person_outline),
        activeIcon: Icon(Icons.person),
        label: 'Profile',
      ),
    ];

    return Scaffold(
      body: Obx(() => pages[controller.currentTabIndex.value]),
      bottomNavigationBar: Obx(
        () => Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowLight,
                blurRadius: 10,
                offset: Offset(0, -5),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: controller.currentTabIndex.value,
            onTap: controller.changeTabIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.white,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.grey,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 12,
            ),
            items: navItems,
          ),
        ),
      ),
    );
  }
}

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final home.SearchController searchController =
        Get.find<home.SearchController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingMedium),
            child: TextField(
              onChanged: searchController.updateSearchText,
              decoration: InputDecoration(
                hintText: 'Search restaurants or cuisines...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: Obx(() => searchController.searchText.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: searchController.clearSearch,
                      )
                    : const SizedBox.shrink()),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusMedium),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppColors.background,
              ),
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (searchController.isSearching.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (searchController.searchText.isEmpty) {
          return const Center(
            child: Text('Start typing to search for restaurants...'),
          );
        }

        if (searchController.searchResults.isEmpty) {
          return const Center(
            child: Text('No restaurants found.'),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(AppDimensions.paddingMedium),
          itemCount: searchController.searchResults.length,
          itemBuilder: (context, index) {
            final restaurant = searchController.searchResults[index];
            return Card(
              margin: const EdgeInsets.only(bottom: AppDimensions.marginMedium),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusSmall),
                  child: Image.network(
                    restaurant.imageUrl,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 60,
                      height: 60,
                      color: AppColors.greyLight,
                      child: const Icon(Icons.restaurant),
                    ),
                  ),
                ),
                title: Text(restaurant.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(restaurant.cuisine),
                    Row(
                      children: [
                        const Icon(Icons.star,
                            size: 16, color: AppColors.accent),
                        Text(' ${restaurant.rating}'),
                        const SizedBox(width: 8),
                        const Icon(Icons.delivery_dining, size: 16),
                        Text(' ${restaurant.deliveryTime} min'),
                      ],
                    ),
                  ],
                ),
                onTap: () =>
                    Get.toNamed('/restaurant-details', arguments: restaurant),
              ),
            );
          },
        );
      }),
    );
  }
}
