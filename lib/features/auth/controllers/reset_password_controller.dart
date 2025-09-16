import 'package:chatter_box/features/auth/services/firebase_auth_service.dart';
import 'package:chatter_box/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:chatter_box/core/utils/validators.dart';
import 'package:flutter/material.dart';

class ResetPasswordController extends GetxController {
  final FirebaseAuthService _authService = Get.find();
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
      await _authService.resetPassword(email.value.trim());

      // Handle reset password logic here
      Get.snackbar(
        'Success',
        'Password reset link sent to your email',
        snackPosition: SnackPosition.BOTTOM,
      );

      // Navigate to next screen (home/dashboard)
      Get.offAllNamed(AppRoutes.signInScreen);
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
