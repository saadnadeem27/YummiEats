import 'package:get/get.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/auth/views/login_view.dart';
import '../modules/auth/views/register_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home/views/main_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/restaurant/views/restaurant_details_view.dart';
import '../modules/restaurant/views/food_details_view.dart';
import '../modules/restaurant/bindings/restaurant_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/cart/views/checkout_view.dart';
import '../modules/cart/bindings/cart_binding.dart';
import '../modules/tracking/views/order_tracking_view.dart';
import '../modules/tracking/bindings/tracking_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.initial,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const MainView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.restaurantDetails,
      page: () => const RestaurantDetailsView(),
      binding: RestaurantBinding(),
    ),
    GetPage(
      name: AppRoutes.foodDetails,
      page: () => const FoodDetailsView(),
      binding: RestaurantBinding(),
    ),
    GetPage(
      name: AppRoutes.cart,
      page: () => const CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: AppRoutes.checkout,
      page: () => const CheckoutView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: AppRoutes.orderTracking,
      page: () => const OrderTrackingView(),
      binding: TrackingBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
  ];
}
