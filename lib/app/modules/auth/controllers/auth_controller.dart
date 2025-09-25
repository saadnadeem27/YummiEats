import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  // Form keys
  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();

  // Text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Observable variables
  final isLoading = false.obs;
  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;
  final rememberMe = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
  }

  Future<void> login() async {
    if (!loginFormKey.currentState!.validate()) return;

    try {
      isLoading.value = true;

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Navigate to home
      Get.offAllNamed('/home');

      Get.snackbar(
        'Success',
        'Welcome back!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Login failed. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register() async {
    if (!registerFormKey.currentState!.validate()) return;

    try {
      isLoading.value = true;

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Navigate to home
      Get.offAllNamed('/home');

      Get.snackbar(
        'Success',
        'Account created successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Registration failed. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;

      // Simulate Google Sign In
      await Future.delayed(const Duration(seconds: 1));

      Get.offAllNamed('/home');

      Get.snackbar(
        'Success',
        'Signed in with Google successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Google Sign In failed. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void goToRegister() {
    Get.toNamed('/register');
  }

  void goToLogin() {
    Get.back();
  }

  void forgotPassword() {
    // Implement forgot password functionality
    Get.snackbar(
      'Info',
      'Forgot password functionality will be implemented',
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (value.length < 10) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }
}
