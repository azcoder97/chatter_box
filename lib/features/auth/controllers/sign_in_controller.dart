import 'package:chatter_box/core/utils/validators.dart';
import 'package:chatter_box/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  // -----------------------------
  // Reactive field values
  // -----------------------------
  final RxString email = ''.obs;
  final RxString password = ''.obs;

  // -----------------------------
  // Reactive error messages
  // -----------------------------
  final RxnString emailError = RxnString();
  final RxnString passwordError = RxnString();

  // -----------------------------
  // Loading state
  // -----------------------------
  final RxBool isLoading = false.obs;

  // -----------------------------
  // Validate all fields
  // -----------------------------
  bool validateForm() {
    emailError.value = Validators.validateEmail(email.value);
    passwordError.value = Validators.validatePassword(password.value);

    return emailError.value == null && passwordError.value == null;
  }

  // -----------------------------
  // Main SignIn Logic
  // -----------------------------
  Future<void> signIn() async {
    if (!validateForm()) return;

    try {
      isLoading.value = true;

      // 🔑 Call your API / Firebase Auth here
      await Future.delayed(const Duration(seconds: 3)); // Mock API call

      // Show success
      Get.snackbar('Success', 'Signed In successfully!');

      // Navigate to next screen (home/dashboard)
      Get.offAllNamed(AppRoutes.chatListScreen);
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // -----------------------------
  // Optional: Real-time validation
  // -----------------------------
  void validateEmailField(String value) {
    email.value = value;
    emailError.value = Validators.validateEmail(value);
  }

  void validatePasswordField(String value) {
    password.value = value;
    passwordError.value = Validators.validatePassword(value);
  }
}
