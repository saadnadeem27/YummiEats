import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final RxString userName = 'John Doe'.obs;
  final RxString userEmail = 'john.doe@example.com'.obs;
  final RxString userPhone = '+1 234 567 8900'.obs;
  final RxString userAvatar =
      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d'.obs;

  final RxBool notificationsEnabled = true.obs;
  final RxBool locationEnabled = true.obs;
  final RxBool darkModeEnabled = false.obs;

  void updateProfile() {
    Get.snackbar('Success', 'Profile updated successfully');
  }

  void logout() {
    Get.dialog(
      AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              Get.offAllNamed('/onboarding');
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  void changePassword() {
    Get.toNamed('/change-password');
  }

  void manageAddresses() {
    Get.toNamed('/addresses');
  }

  void managePaymentMethods() {
    Get.toNamed('/payment-methods');
  }

  void viewOrderHistory() {
    Get.toNamed('/order-history');
  }

  void viewFavorites() {
    Get.toNamed('/favorites');
  }

  void contactSupport() {
    Get.snackbar('Support', 'Redirecting to support...');
  }

  void viewTermsAndConditions() {
    Get.snackbar('Terms', 'Opening terms and conditions...');
  }

  void viewPrivacyPolicy() {
    Get.snackbar('Privacy', 'Opening privacy policy...');
  }

  void rateApp() {
    Get.snackbar('Rating', 'Thank you for rating our app!');
  }

  void shareApp() {
    Get.snackbar('Share', 'Sharing app with friends...');
  }
}
