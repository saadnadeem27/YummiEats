import 'package:get/get.dart';
import '../../onboarding/views/onboarding_view.dart';
import '../../onboarding/bindings/onboarding_binding.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToOnboarding();
  }

  void _navigateToOnboarding() async {
    await Future.delayed(const Duration(seconds: 3));
    // Navigate to onboarding with direct navigation
    OnboardingBinding().dependencies();
    Get.off(() => const OnboardingView());
  }
}
