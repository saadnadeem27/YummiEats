import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFFFF6B35);
  static const Color primaryLight = Color(0xFFFF8A65);
  static const Color primaryDark = Color(0xFFE64A19);

  // Secondary Colors
  static const Color secondary = Color(0xFF2E7D32);
  static const Color secondaryLight = Color(0xFF4CAF50);
  static const Color secondaryDark = Color(0xFF1B5E20);

  // Accent Colors
  static const Color accent = Color(0xFFFFC107);
  static const Color accentLight = Color(0xFFFFF350);
  static const Color accentDark = Color(0xFFC79100);

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey = Color(0xFF757575);
  static const Color greyLight = Color(0xFFBDBDBD);
  static const Color greyDark = Color(0xFF424242);
  static const Color background = Color(0xFFF8F9FA);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryLight],
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [secondary, secondaryLight],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accent, accentLight],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFFFFF), Color(0xFFF5F5F5)],
  );

  // Shadow Colors
  static const Color shadowLight = Color(0x1A000000);
  static const Color shadowMedium = Color(0x33000000);
  static const Color shadowDark = Color(0x4D000000);
}
