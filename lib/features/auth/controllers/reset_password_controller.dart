import 'package:get/get.dart';
import 'package:chatter_box/core/utils/validators.dart';
import 'package:flutter/material.dart';

class ResetPasswordController extends GetxController {
  // -----------------------------
  // Reactive field values
  // -----------------------------
  final RxString email = ''.obs;

  // -----------------------------
  // Reactive error messages
  // -----------------------------
  final RxnString emailError = RxnString();

  // -----------------------------
  // Loading state
  // -----------------------------
  final RxBool isLoading = false.obs;

  // -----------------------------
  // Validate field
  // -----------------------------
  bool validateEmail() {
    emailError.value = Validators.validateEmail(email.value);
    return emailError.value == null;
  }

  // -----------------------------
  // Reset password logic
  // -----------------------------
  Future<void> resetPassword() async {
    if (!validateEmail()) return;

    try {
      isLoading.value = true;

      // 🔑 Call your API / Firebase password reset here
      await Future.delayed(const Duration(seconds: 2)); // Mock API call

      // Handle reset password logic here
      Get.snackbar(
        'Success',
        'Password reset link sent to your email',
        snackPosition: SnackPosition.BOTTOM,
      );
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
  // Optional: real-time validation
  // -----------------------------
  void validateEmailField(String value) {
    email.value = value;
    emailError.value = Validators.validateEmail(value);
  }
}
