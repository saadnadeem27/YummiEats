import 'package:get/get.dart';
import '../../../data/models/restaurant.dart';
import '../../../data/models/category.dart';
import '../../../data/services/dummy_data_service.dart';
import '../../restaurant/views/restaurant_details_view.dart';
import '../../restaurant/bindings/restaurant_binding.dart';

class HomeController extends GetxController {
  final currentTabIndex = 0.obs;

  final restaurants = <Restaurant>[].obs;
  final categories = <Category>[].obs;
  final popularRestaurants = <Restaurant>[].obs;
  final nearbyRestaurants = <Restaurant>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void changeTabIndex(int index) {
    currentTabIndex.value = index;
  }

  Future<void> loadData() async {
    try {
      isLoading.value = true;

      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));

      // Load dummy data
      categories.value = DummyDataService.getCategories();
      restaurants.value = DummyDataService.getRestaurants();

      // Filter popular and nearby restaurants
      popularRestaurants.value =
          restaurants.where((restaurant) => restaurant.rating >= 4.5).toList();

      nearbyRestaurants.value = restaurants
          .where((restaurant) => restaurant.deliveryTime <= 30)
          .toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load data');
    } finally {
      isLoading.value = false;
    }
  }

  void refreshData() {
    loadData();
  }

  void goToRestaurant(Restaurant restaurant) {
    RestaurantBinding().dependencies();
    Get.to(() => const RestaurantDetailsView(), arguments: restaurant);
  }

  void goToCategory(Category category) {
    RestaurantBinding().dependencies();
    Get.to(() => const RestaurantDetailsView(),
        arguments: {'category': category});
  }

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }
}

class SearchController extends GetxController {
  final searchText = ''.obs;
  final searchResults = <Restaurant>[].obs;
  final isSearching = false.obs;

  void updateSearchText(String text) {
    searchText.value = text;
    if (text.isEmpty) {
      searchResults.clear();
      return;
    }
    _performSearch(text);
  }

  void _performSearch(String query) {
    isSearching.value = true;

    // Simulate search delay
    Future.delayed(const Duration(milliseconds: 300), () {
      final allRestaurants = DummyDataService.getRestaurants();
      searchResults.value = allRestaurants
          .where((restaurant) =>
              restaurant.name.toLowerCase().contains(query.toLowerCase()) ||
              restaurant.cuisine.toLowerCase().contains(query.toLowerCase()) ||
              restaurant.categories.any((category) =>
                  category.toLowerCase().contains(query.toLowerCase())))
          .toList();
      isSearching.value = false;
    });
  }

  void clearSearch() {
    searchText.value = '';
    searchResults.clear();
  }
}
