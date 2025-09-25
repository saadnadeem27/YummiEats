import 'package:get/get.dart';
import '../controllers/tracking_controller.dart';

class TrackingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TrackingController());
  }
}
