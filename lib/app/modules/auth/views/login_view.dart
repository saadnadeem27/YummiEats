import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../controllers/auth_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_strings.dart';
import '../../../global_widgets/custom_button.dart';
import '../../../global_widgets/custom_textfield.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppDimensions.paddingLarge),
            child: Form(
              key: controller.loginFormKey,
              child: AnimationLimiter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 500),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(child: widget),
                    ),
                    children: [
                      const SizedBox(height: AppDimensions.marginXLarge * 2),

                      // Logo and Title
                      Center(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(
                                  AppDimensions.paddingLarge),
                              decoration: const BoxDecoration(
                                color: AppColors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.restaurant,
                                size: AppDimensions.iconXLarge,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: AppDimensions.marginMedium),
                            const Text(
                              AppStrings.appName,
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                              ),
                            ),
                            const SizedBox(height: AppDimensions.marginSmall),
                            const Text(
                              'Welcome back! Sign in to continue',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppDimensions.marginXLarge),

                      // Email Field
                      CustomTextField(
                        controller: controller.emailController,
                        labelText: AppStrings.email,
                        hintText: 'Enter your email',
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: const Icon(Icons.email_outlined),
                        validator: controller.validateEmail,
                      ),

                      const SizedBox(height: AppDimensions.marginMedium),

                      // Password Field
                      Obx(
                        () => CustomTextField(
                          controller: controller.passwordController,
                          labelText: AppStrings.password,
                          hintText: 'Enter your password',
                          obscureText: !controller.isPasswordVisible.value,
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: controller.togglePasswordVisibility,
                          ),
                          validator: controller.validatePassword,
                        ),
                      ),

                      const SizedBox(height: AppDimensions.marginMedium),

                      // Remember Me and Forgot Password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => Row(
                              children: [
                                Checkbox(
                                  value: controller.rememberMe.value,
                                  onChanged: (_) =>
                                      controller.toggleRememberMe(),
                                  fillColor:
                                      WidgetStateProperty.all(AppColors.white),
                                  checkColor: AppColors.primary,
                                ),
                                const Text(
                                  'Remember me',
                                  style: TextStyle(color: AppColors.white),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: controller.forgotPassword,
                            child: const Text(
                              AppStrings.forgotPassword,
                              style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: AppDimensions.marginXLarge),

                      // Login Button
                      Obx(
                        () => CustomButton(
                          text: AppStrings.signIn,
                          onPressed: controller.login,
                          isLoading: controller.isLoading.value,
                          backgroundColor: AppColors.white,
                          foregroundColor: AppColors.primary,
                          width: double.infinity,
                        ),
                      ),

                      const SizedBox(height: AppDimensions.marginLarge),

                      // Divider
                      const Row(
                        children: [
                          Expanded(child: Divider(color: Colors.white30)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              AppStrings.orContinueWith,
                              style: TextStyle(color: Colors.white70),
                            ),
                          ),
                          Expanded(child: Divider(color: Colors.white30)),
                        ],
                      ),

                      const SizedBox(height: AppDimensions.marginLarge),

                      // Google Sign In
                      CustomButton(
                        text: AppStrings.signInWithGoogle,
                        onPressed: controller.signInWithGoogle,
                        backgroundColor: AppColors.white,
                        foregroundColor: AppColors.black,
                        width: double.infinity,
                        icon: Image.network(
                          'https://developers.google.com/identity/images/g-logo.png',
                          width: 20,
                          height: 20,
                        ),
                      ),

                      const SizedBox(height: AppDimensions.marginXLarge),

                      // Sign Up Link
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              AppStrings.dontHaveAccount,
                              style: TextStyle(color: Colors.white70),
                            ),
                            TextButton(
                              onPressed: controller.goToRegister,
                              child: const Text(
                                AppStrings.signUp,
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
