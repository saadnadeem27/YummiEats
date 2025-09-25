import 'package:get/get.dart';
import '../../../data/models/restaurant.dart';
import '../../../data/models/food_item.dart';
import '../../../data/services/dummy_data_service.dart';
import '../../cart/controllers/cart_controller.dart';

class RestaurantController extends GetxController {
  final restaurant = Rx<Restaurant?>(null);
  final menuItems = <FoodItem>[].obs;
  final categories = <String>[].obs;
  final selectedCategory = 'All'.obs;
  final isLoading = false.obs;
  final isFavorite = false.obs;

  CartController get cartController => Get.find<CartController>();

  @override
  void onInit() {
    super.onInit();
    final dynamic argument = Get.arguments;

    if (argument is Restaurant) {
      // If Restaurant object is passed
      restaurant.value = argument;
      isFavorite.value = argument.isFavorite;
      loadMenuItems();
    } else if (argument is String) {
      // If restaurant ID is passed, find the restaurant
      loadRestaurantById(argument);
    }
  }

  void loadRestaurantById(String restaurantId) {
    try {
      isLoading.value = true;

      // Find restaurant from dummy data service
      final restaurants = DummyDataService.getRestaurants();
      final foundRestaurant = restaurants.firstWhere(
        (r) => r.id == restaurantId,
        orElse: () => restaurants.first, // Fallback to first restaurant
      );

      restaurant.value = foundRestaurant;
      isFavorite.value = foundRestaurant.isFavorite;
      loadMenuItems();
    } catch (e) {
      Get.snackbar('Error', 'Restaurant not found');
      Get.back();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMenuItems() async {
    if (restaurant.value == null) return;

    try {
      isLoading.value = true;

      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));

      menuItems.value = DummyDataService.getFoodItems(restaurant.value!.id);

      // Extract categories
      final allCategories = {'All', ...menuItems.map((item) => item.category)};
      categories.value = allCategories.toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load menu items');
    } finally {
      isLoading.value = false;
    }
  }

  List<FoodItem> get filteredMenuItems {
    if (selectedCategory.value == 'All') {
      return menuItems;
    }
    return menuItems
        .where((item) => item.category == selectedCategory.value)
        .toList();
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;

    Get.snackbar(
      isFavorite.value ? 'Added to Favorites' : 'Removed from Favorites',
      isFavorite.value
          ? '${restaurant.value?.name} has been added to your favorites'
          : '${restaurant.value?.name} has been removed from your favorites',
    );
  }

  void addToCart(FoodItem foodItem) {
    Get.toNamed('/food-details', arguments: foodItem);
  }
}

class FoodDetailsController extends GetxController {
  final foodItem = Rx<FoodItem?>(null);
  final quantity = 1.obs;
  final selectedAddOns = <FoodAddOn>[].obs;
  final selectedVariant = Rx<FoodVariant?>(null);
  final specialInstructions = ''.obs;
  final totalPrice = 0.0.obs;

  CartController get cartController => Get.find<CartController>();

  @override
  void onInit() {
    super.onInit();
    final dynamic argument = Get.arguments;

    if (argument is FoodItem) {
      foodItem.value = argument;

      // Set default variant if available
      if (argument.variants.isNotEmpty) {
        selectedVariant.value =
            argument.variants.first.copyWith(isSelected: true);
      }
    } else if (argument is String) {
      // If food item ID is passed, find the food item
      loadFoodItemById(argument);
    }
  }

  void loadFoodItemById(String foodId) {
    try {
      // Find food item from dummy data service
      final restaurants = DummyDataService.getRestaurants();
      FoodItem? foundFoodItem;

      for (var restaurant in restaurants) {
        for (var category in restaurant.menuCategories) {
          final item = category.items.firstWhere(
            (item) => item.id == foodId,
            orElse: () => FoodItem(
              id: '',
              name: '',
              description: '',
              price: 0.0,
              imageUrl: '',
              category: '',
              isVegetarian: false,
              rating: 0.0,
              preparationTime: 0,
              variants: [],
              addOns: [],
            ),
          );
          if (item.id.isNotEmpty) {
            foundFoodItem = item;
            break;
          }
        }
        if (foundFoodItem != null) break;
      }

      if (foundFoodItem != null && foundFoodItem.id.isNotEmpty) {
        foodItem.value = foundFoodItem;

        // Set default variant if available
        if (foundFoodItem.variants.isNotEmpty) {
          selectedVariant.value = foundFoodItem.variants.first;
        }

        calculateTotalPrice();
      } else {
        Get.snackbar('Error', 'Food item not found');
        Get.back();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load food item');
      Get.back();
    }
  }

  void updateQuantity(int newQuantity) {
    if (newQuantity > 0) {
      quantity.value = newQuantity;
      calculateTotalPrice();
    }
  }

  void toggleAddOn(FoodAddOn addOn) {
    final index = selectedAddOns.indexWhere((item) => item.id == addOn.id);
    if (index != -1) {
      selectedAddOns.removeAt(index);
    } else {
      selectedAddOns.add(addOn.copyWith(isSelected: true));
    }
    calculateTotalPrice();
  }

  void selectVariant(FoodVariant variant) {
    selectedVariant.value = variant.copyWith(isSelected: true);
    calculateTotalPrice();
  }

  void updateSpecialInstructions(String instructions) {
    specialInstructions.value = instructions;
  }

  void calculateTotalPrice() {
    if (foodItem.value == null) return;

    double basePrice = selectedVariant.value?.price ?? foodItem.value!.price;
    double addOnsPrice =
        selectedAddOns.fold(0.0, (sum, addOn) => sum + addOn.price);

    totalPrice.value = (basePrice + addOnsPrice) * quantity.value;
  }

  void addToCart() {
    if (foodItem.value == null) return;

    cartController.addToCart(
      foodItem.value!,
      quantity: quantity.value,
      selectedAddOns: selectedAddOns.toList(),
      selectedVariant: selectedVariant.value,
      specialInstructions: specialInstructions.value.isNotEmpty
          ? specialInstructions.value
          : null,
    );

    Get.back();
  }
}
