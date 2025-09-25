import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../controllers/onboarding_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_strings.dart';
import '../../../global_widgets/custom_button.dart';
import '../../../global_widgets/custom_image.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Skip Button
              Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: controller.skipOnboarding,
                    child: const Text(
                      AppStrings.skip,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),

              // Page View
              Expanded(
                flex: 3,
                child: PageView.builder(
                  controller: pageController,
                  onPageChanged: controller.goToPage,
                  itemCount: controller.onboardingItems.length,
                  itemBuilder: (context, index) {
                    final item = controller.onboardingItems[index];
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 500),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: Padding(
                            padding: const EdgeInsets.all(
                                AppDimensions.paddingLarge),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Image
                                Container(
                                  height: 300,
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(
                                    bottom: AppDimensions.marginLarge,
                                  ),
                                  child: CustomNetworkImage(
                                    imageUrl: item['image']!,
                                    fit: BoxFit.contain,
                                    borderRadius: BorderRadius.circular(
                                      AppDimensions.radiusLarge,
                                    ),
                                  ),
                                ),

                                // Title
                                Text(
                                  item['title']!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.white,
                                    height: 1.2,
                                  ),
                                ),

                                const SizedBox(
                                    height: AppDimensions.marginMedium),

                                // Subtitle
                                Text(
                                  item['subtitle']!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: AppColors.white,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Page Indicator and Button
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.paddingLarge),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Page Indicator
                      Obx(
                        () => SmoothPageIndicator(
                          controller: pageController,
                          count: controller.onboardingItems.length,
                          effect: const WormEffect(
                            dotWidth: 12,
                            dotHeight: 12,
                            activeDotColor: AppColors.white,
                            dotColor: Colors.white30,
                            spacing: 8,
                          ),
                        ),
                      ),

                      // Button
                      Obx(
                        () => CustomButton(
                          text: controller.currentIndex.value ==
                                  controller.onboardingItems.length - 1
                              ? AppStrings.getStarted
                              : AppStrings.next,
                          onPressed: controller.nextPage,
                          backgroundColor: AppColors.white,
                          foregroundColor: AppColors.primary,
                          width: double.infinity,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
