import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'app/core/theme/app_theme.dart';
import 'app/core/constants/app_strings.dart';
import 'app/modules/splash/views/splash_view.dart';
import 'app/modules/splash/bindings/splash_binding.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const YummiEatsApp());
}

class YummiEatsApp extends StatelessWidget {
  const YummiEatsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStrings.appName,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashView(),
      initialBinding: SplashBinding(),
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
