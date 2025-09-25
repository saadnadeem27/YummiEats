import 'package:get/get.dart';
import '../controllers/home_controller.dart' as home;
import '../../cart/controllers/cart_controller.dart';
import '../../tracking/controllers/tracking_controller.dart';
import '../../profile/controllers/profile_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<home.HomeController>(() => home.HomeController());
    Get.lazyPut<home.SearchController>(() => home.SearchController());
    Get.lazyPut<CartController>(() => CartController());
    Get.lazyPut<TrackingController>(() => TrackingController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
