import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../core/constants/app_colors.dart';
import '../../showcase/views/features_showcase_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _fadeController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _startAnimations();
    _navigateToNextScreen();
  }

  void _startAnimations() async {
    _fadeController.forward();
    await Future.delayed(const Duration(milliseconds: 500));
    _pulseController.repeat(reverse: true);
  }

  void _navigateToNextScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAll(() => const FeaturesShowcaseView());
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary,
              AppColors.accent,
              AppColors.primary.withOpacity(0.8),
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: AnimationLimiter(
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Animated Logo
                        AnimationConfiguration.staggeredList(
                          position: 0,
                          duration: const Duration(milliseconds: 800),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: AnimatedBuilder(
                                animation: _pulseAnimation,
                                builder: (context, child) {
                                  return Transform.scale(
                                    scale: _pulseAnimation.value,
                                    child: Container(
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            blurRadius: 20,
                                            spreadRadius: 5,
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.restaurant_menu,
                                        size: 60,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        // App Name
                        AnimationConfiguration.staggeredList(
                          position: 1,
                          duration: const Duration(milliseconds: 800),
                          child: SlideAnimation(
                            verticalOffset: 30.0,
                            child: FadeInAnimation(
                              child: FadeTransition(
                                opacity: _fadeAnimation,
                                child: const Text(
                                  '🍽️ Yummi Eats',
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Tagline
                        AnimationConfiguration.staggeredList(
                          position: 2,
                          duration: const Duration(milliseconds: 800),
                          child: SlideAnimation(
                            verticalOffset: 20.0,
                            child: FadeInAnimation(
                              child: FadeTransition(
                                opacity: _fadeAnimation,
                                child: Text(
                                  'Delicious food, delivered fast',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white.withOpacity(0.9),
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 50),

                        // Loading Indicator
                        AnimationConfiguration.staggeredList(
                          position: 3,
                          duration: const Duration(milliseconds: 800),
                          child: SlideAnimation(
                            verticalOffset: 20.0,
                            child: FadeInAnimation(
                              child: FadeTransition(
                                opacity: _fadeAnimation,
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white.withOpacity(0.8),
                                    ),
                                    strokeWidth: 3,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Bottom Section
                AnimationConfiguration.staggeredList(
                  position: 4,
                  duration: const Duration(milliseconds: 1000),
                  child: SlideAnimation(
                    verticalOffset: 30.0,
                    child: FadeInAnimation(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(
                              'Made with ❤️ for food lovers',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Version 1.0.0',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
