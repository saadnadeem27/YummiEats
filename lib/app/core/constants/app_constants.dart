class AppDimensions {
  // Padding
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;

  // Margin
  static const double marginSmall = 8.0;
  static const double marginMedium = 16.0;
  static const double marginLarge = 24.0;
  static const double marginXLarge = 32.0;

  // Border Radius
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 24.0;
  static const double radiusRound = 50.0;

  // Icon Sizes
  static const double iconSmall = 16.0;
  static const double iconMedium = 24.0;
  static const double iconLarge = 32.0;
  static const double iconXLarge = 48.0;

  // Button Heights
  static const double buttonHeight = 48.0;
  static const double buttonHeightLarge = 56.0;
  static const double buttonHeightSmall = 40.0;

  // Card Dimensions
  static const double cardElevation = 4.0;
  static const double cardElevationLarge = 8.0;

  // App Bar
  static const double appBarHeight = 56.0;
  static const double appBarElevation = 0.0;

  // Bottom Navigation
  static const double bottomNavHeight = 80.0;

  // List Item
  static const double listItemHeight = 72.0;
  static const double listItemMinHeight = 56.0;

  // Image Dimensions
  static const double avatarRadius = 20.0;
  static const double avatarRadiusLarge = 40.0;
  static const double categoryImageSize = 60.0;
  static const double restaurantImageHeight = 200.0;
  static const double foodImageSize = 80.0;
}

class AppAnimations {
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration xSlow = Duration(milliseconds: 1000);
}

class AppConstants {
  static const String baseUrl = 'https://api.yummi-eats.com/v1';
  static const String imageBaseUrl = 'https://images.yummi-eats.com';

  // SharedPreferences Keys
  static const String keyIsLoggedIn = 'isLoggedIn';
  static const String keyUserToken = 'userToken';
  static const String keyUserData = 'userData';
  static const String keyIsFirstTime = 'isFirstTime';
  static const String keyLanguage = 'language';
  static const String keyTheme = 'theme';

  // Map
  static const double defaultLatitude = 37.7749;
  static const double defaultLongitude = -122.4194;
  static const double mapZoom = 15.0;

  // Pagination
  static const int pageSize = 20;

  // Network
  static const int connectionTimeout = 30000;
  static const int receiveTimeout = 30000;
}
