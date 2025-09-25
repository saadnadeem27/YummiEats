import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/onboarding_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../auth/views/login_view.dart';
import '../../auth/bindings/auth_binding.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.accent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: PageView(
            controller: controller.pageController,
            onPageChanged: (index) => controller.currentPage.value = index,
            children: [
              _buildOnboardingPage(
                title: 'Welcome to Yummi Eats',
                description:
                    'Discover delicious food from the best restaurants in your area with fast delivery.',
                icon: Icons.restaurant_menu,
                index: 0,
              ),
              _buildOnboardingPage(
                title: 'Fast Delivery',
                description:
                    'Get your favorite meals delivered quickly and safely to your doorstep.',
                icon: Icons.delivery_dining,
                index: 1,
              ),
              _buildOnboardingPage(
                title: 'Easy Ordering',
                description:
                    'Browse menus, customize your order, and pay seamlessly with just a few taps.',
                icon: Icons.touch_app,
                index: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOnboardingPage({
    required String title,
    required String description,
    required IconData icon,
    required int index,
  }) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Skip button
          if (index < 2)
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () => _navigateToLogin(),
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

          const Spacer(),

          // Icon
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 60,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 48),

          // Title
          Text(
            title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 24),

          // Description
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),

          const Spacer(),

          // Page indicators
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (dotIndex) => Container(
                    width: dotIndex == controller.currentPage.value ? 24 : 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: dotIndex == controller.currentPage.value
                          ? Colors.white
                          : Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              )),

          const SizedBox(height: 48),

          // Action button
          if (index == 2)
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () => _navigateToLogin(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          else
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () => controller.nextPage(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.2),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  side: const BorderSide(color: Colors.white, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _navigateToLogin() {
    AuthBinding().dependencies();
    Get.off(() => const LoginView());
  }
}
