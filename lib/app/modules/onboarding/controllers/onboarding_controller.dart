import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../auth/views/login_view.dart';
import '../../auth/bindings/auth_binding.dart';

class OnboardingController extends GetxController {
  late PageController pageController;
  final currentPage = 0.obs;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void nextPage() {
    if (currentPage.value < 2) {
      currentPage.value++;
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void skipToLogin() {
    completeOnboarding();
  }

  void completeOnboarding() {
    // Navigate to login using direct navigation
    AuthBinding().dependencies();
    Get.off(() => const LoginView());
  }

  void goToPage(int index) {
    currentPage.value = index;
  }
}
