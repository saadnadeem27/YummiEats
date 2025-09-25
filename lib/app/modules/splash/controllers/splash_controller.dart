import 'package:get/get.dart';
import '../../showcase/views/features_showcase_view.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToShowcase();
  }

  void _navigateToShowcase() async {
    await Future.delayed(const Duration(seconds: 3));
    // Navigate to showcase view with direct navigation
    Get.off(() => const FeaturesShowcaseView());
  }
}
