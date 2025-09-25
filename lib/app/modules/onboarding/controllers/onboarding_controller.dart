import 'package:get/get.dart';

class OnboardingController extends GetxController {
  final currentIndex = 0.obs;

  final onboardingItems = [
    {
      'title': 'Discover Restaurants',
      'subtitle':
          'Find the best restaurants and cuisines near you with our extensive collection',
      'image': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4',
    },
    {
      'title': 'Easy Ordering',
      'subtitle':
          'Order your favorite food with just a few taps. Simple, fast, and convenient',
      'image': 'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136',
    },
    {
      'title': 'Fast Delivery',
      'subtitle':
          'Get your food delivered fast and fresh to your doorstep with real-time tracking',
      'image': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b',
    },
  ];

  void nextPage() {
    if (currentIndex.value < onboardingItems.length - 1) {
      currentIndex.value++;
    } else {
      completeOnboarding();
    }
  }

  void skipOnboarding() {
    completeOnboarding();
  }

  void completeOnboarding() {
    // Save that user has completed onboarding
    Get.offAllNamed('/login');
  }

  void goToPage(int index) {
    currentIndex.value = index;
  }
}
