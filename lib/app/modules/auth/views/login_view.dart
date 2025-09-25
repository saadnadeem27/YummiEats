import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../../../core/constants/app_colors.dart';
import 'register_view.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.accent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: controller.loginFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 60),

                  // App Logo
                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.restaurant_menu,
                      size: 50,
                      color: AppColors.primary,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // App Name
                  const Text(
                    'Yummi Eats',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Sign in to continue',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 48),

                  // Email Field
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextFormField(
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Password Field
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Obx(() => TextFormField(
                          controller: controller.passwordController,
                          obscureText: !controller.isPasswordVisible.value,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: controller.togglePasswordVisibility,
                              icon: Icon(
                                controller.isPasswordVisible.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(16),
                          ),
                        )),
                  ),

                  const SizedBox(height: 24),

                  // Remember Me & Forgot Password
                  Row(
                    children: [
                      Obx(() => Checkbox(
                            value: controller.rememberMe.value,
                            onChanged: (value) =>
                                controller.rememberMe.value = value ?? false,
                            activeColor: Colors.white,
                            checkColor: AppColors.primary,
                          )),
                      const Text(
                        'Remember me',
                        style: TextStyle(color: Colors.white),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          // TODO: Implement forgot password
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Login Button
                  Obx(() => SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : controller.login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: controller.isLoading.value
                              ? const CircularProgressIndicator(
                                  color: AppColors.primary,
                                )
                              : const Text(
                                  'Sign In',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      )),

                  const SizedBox(height: 24),

                  // Register Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () => Get.to(() => const RegisterView()),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Social Login
                  const Text(
                    'Or continue with',
                    style: TextStyle(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // TODO: Google login
                          },
                          icon: const Icon(Icons.g_mobiledata,
                              color: Colors.white),
                          label: const Text(
                            'Google',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.white),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // TODO: Facebook login
                          },
                          icon: const Icon(Icons.facebook, color: Colors.white),
                          label: const Text(
                            'Facebook',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.white),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
