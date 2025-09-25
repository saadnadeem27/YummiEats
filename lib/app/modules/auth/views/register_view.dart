import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../controllers/auth_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_strings.dart';
import '../../../global_widgets/custom_button.dart';
import '../../../global_widgets/custom_textfield.dart';

class RegisterView extends GetView<AuthController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.secondaryGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppDimensions.paddingLarge),
            child: Form(
              key: controller.registerFormKey,
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
                      // Back Button
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AppColors.white,
                        ),
                      ),

                      const SizedBox(height: AppDimensions.marginLarge),

                      // Title
                      const Center(
                        child: Column(
                          children: [
                            Text(
                              'Create Account',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                              ),
                            ),
                            SizedBox(height: AppDimensions.marginSmall),
                            Text(
                              'Join us and discover amazing food',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppDimensions.marginXLarge),

                      // Full Name Field
                      CustomTextField(
                        controller: controller.nameController,
                        labelText: AppStrings.fullName,
                        hintText: 'Enter your full name',
                        prefixIcon: const Icon(Icons.person_outline),
                        validator: controller.validateName,
                      ),

                      const SizedBox(height: AppDimensions.marginMedium),

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

                      // Phone Field
                      CustomTextField(
                        controller: controller.phoneController,
                        labelText: AppStrings.phoneNumber,
                        hintText: 'Enter your phone number',
                        keyboardType: TextInputType.phone,
                        prefixIcon: const Icon(Icons.phone_outlined),
                        validator: controller.validatePhone,
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

                      // Confirm Password Field
                      Obx(
                        () => CustomTextField(
                          controller: controller.confirmPasswordController,
                          labelText: AppStrings.confirmPassword,
                          hintText: 'Confirm your password',
                          obscureText:
                              !controller.isConfirmPasswordVisible.value,
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isConfirmPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed:
                                controller.toggleConfirmPasswordVisibility,
                          ),
                          validator: controller.validateConfirmPassword,
                        ),
                      ),

                      const SizedBox(height: AppDimensions.marginXLarge),

                      // Register Button
                      Obx(
                        () => CustomButton(
                          text: AppStrings.signUp,
                          onPressed: controller.register,
                          isLoading: controller.isLoading.value,
                          backgroundColor: AppColors.white,
                          foregroundColor: AppColors.secondary,
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

                      // Sign In Link
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              AppStrings.alreadyHaveAccount,
                              style: TextStyle(color: Colors.white70),
                            ),
                            TextButton(
                              onPressed: controller.goToLogin,
                              child: const Text(
                                AppStrings.signIn,
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
