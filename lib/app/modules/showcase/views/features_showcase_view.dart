import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../auth/views/login_view.dart';
import '../../home/views/main_view.dart';
import '../../restaurant/views/restaurant_details_view.dart';
import '../../restaurant/views/food_details_view.dart';
import '../../cart/views/cart_view.dart';
import '../../tracking/views/tracking_view.dart';
import '../../profile/views/profile_view.dart';
import '../../home/bindings/home_binding.dart';
import '../../auth/bindings/auth_binding.dart';
import '../../restaurant/bindings/restaurant_binding.dart';
import '../../cart/bindings/cart_binding.dart';
import '../../tracking/bindings/tracking_binding.dart';
import '../../profile/bindings/profile_binding.dart';

class FeaturesShowcaseView extends StatelessWidget {
  const FeaturesShowcaseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Yummi Eats Features',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.accent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // App Title
              const Text(
                '🍽️ Yummi Eats',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Complete Food Delivery App',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),

              const SizedBox(height: 40),

              // Features Grid
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
                children: [
                  _buildFeatureCard(
                    icon: Icons.login,
                    title: 'Authentication',
                    description: 'Login/Register with validation',
                    onTap: () {
                      AuthBinding().dependencies();
                      Get.to(() => const LoginView());
                    },
                  ),
                  _buildFeatureCard(
                    icon: Icons.home,
                    title: 'Home Dashboard',
                    description: 'Browse restaurants & categories',
                    onTap: () {
                      HomeBinding().dependencies();
                      Get.to(() => const MainView());
                    },
                  ),
                  _buildFeatureCard(
                    icon: Icons.restaurant,
                    title: 'Restaurant Details',
                    description: 'Menu browsing with categories',
                    onTap: () {
                      RestaurantBinding().dependencies();
                      Get.to(() => const RestaurantDetailsView(),
                          arguments: 'rest1');
                    },
                  ),
                  _buildFeatureCard(
                    icon: Icons.fastfood,
                    title: 'Food Customization',
                    description: 'Variants, add-ons & quantity',
                    onTap: () {
                      RestaurantBinding().dependencies();
                      Get.to(() => const FoodDetailsView(), arguments: 'food1');
                    },
                  ),
                  _buildFeatureCard(
                    icon: Icons.shopping_cart,
                    title: 'Cart Management',
                    description: 'Add/remove items & checkout',
                    onTap: () {
                      CartBinding().dependencies();
                      Get.to(() => const CartView());
                    },
                  ),
                  _buildFeatureCard(
                    icon: Icons.delivery_dining,
                    title: 'Order Tracking',
                    description: 'Real-time order status',
                    onTap: () {
                      TrackingBinding().dependencies();
                      Get.to(() => const TrackingView());
                    },
                  ),
                  _buildFeatureCard(
                    icon: Icons.person,
                    title: 'User Profile',
                    description: 'Settings & preferences',
                    onTap: () {
                      ProfileBinding().dependencies();
                      Get.to(() => const ProfileView());
                    },
                  ),
                  _buildFeatureCard(
                    icon: Icons.search,
                    title: 'Search & Filter',
                    description: 'Find restaurants & food',
                    onTap: () {
                      HomeBinding().dependencies();
                      Get.to(() => const MainView());
                    },
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Technical Stack
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '⚡ Technical Stack',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildTechItem(
                        '🎯 Flutter 3.6.0 - Cross-platform framework'),
                    _buildTechItem(
                        '🚀 GetX 4.6.6 - State management & routing'),
                    _buildTechItem(
                        '🎨 Material Design 3 - Modern UI components'),
                    _buildTechItem('✨ Animations - Smooth & engaging UX'),
                    _buildTechItem('📱 Responsive - Works on all screen sizes'),
                    _buildTechItem('🔄 Real-time - Live order tracking'),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Features Summary
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '✅ Completed Features',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildFeatureItem(
                        'Complete onboarding flow with animations'),
                    _buildFeatureItem('User authentication (login/register)'),
                    _buildFeatureItem('Home dashboard with categories'),
                    _buildFeatureItem('Restaurant browsing & search'),
                    _buildFeatureItem('Food item details with customization'),
                    _buildFeatureItem('Cart management with quantity controls'),
                    _buildFeatureItem('Checkout process with payment options'),
                    _buildFeatureItem('Order tracking with status updates'),
                    _buildFeatureItem('User profile with settings'),
                    _buildFeatureItem('Professional gradients & animations'),
                    _buildFeatureItem('Responsive design for all devices'),
                    _buildFeatureItem('Clean architecture with MVC pattern'),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Navigation Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.toNamed('/home'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Explore the App 🚀',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: Colors.white,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withOpacity(0.8),
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTechItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white.withOpacity(0.9),
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: Colors.white,
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
