import 'package:chatter_box/core/utils/validators.dart';
import 'package:chatter_box/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  // -----------------------------
  // Reactive field values
  // -----------------------------
  final RxString fullName = ''.obs;
  final RxString email = ''.obs;
  final RxString password = ''.obs;
  final RxString confirmPassword = ''.obs;

  // -----------------------------
  // Reactive error messages
  // -----------------------------
  final RxnString fullNameError = RxnString();
  final RxnString emailError = RxnString();
  final RxnString passwordError = RxnString();
  final RxnString confirmPasswordError = RxnString();

  // -----------------------------
  // Loading state
  // -----------------------------
  final RxBool isLoading = false.obs;

  // -----------------------------
  // Validate all fields
  // -----------------------------
  bool validateForm() {
    fullNameError.value = Validators.validateName(fullName.value);
    emailError.value = Validators.validateEmail(email.value);
    passwordError.value = Validators.validatePassword(password.value);
    confirmPasswordError.value = Validators.validateConfirmPassword(
      password.value,
      confirmPassword.value,
    );

    return fullNameError.value == null &&
        emailError.value == null &&
        passwordError.value == null &&
        confirmPasswordError.value == null;
  }

  // -----------------------------
  // Main SignUp Logic
  // -----------------------------
  Future<void> signUp() async {
    if (!validateForm()) return;

    try {
      isLoading.value = true;

      // 🔑 Call your API / Firebase Auth here
      await Future.delayed(const Duration(seconds: 3)); // Mock API call

      // Show success
      Get.snackbar('Success', 'Account created successfully!');

      // Navigate to sign-in
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
  // Optional: Individual real-time validation
  // -----------------------------
  void validateFullName(String value) {
    fullName.value = value;
    fullNameError.value = Validators.validateName(value);
  }

  void validateEmail(String value) {
    email.value = value;
    emailError.value = Validators.validateEmail(value);
  }

  void validatePassword(String value) {
    password.value = value;
    passwordError.value = Validators.validatePassword(value);

    // Revalidate confirm password if already typed
    if (confirmPassword.value.isNotEmpty) {
      confirmPasswordError.value = Validators.validateConfirmPassword(
        password.value,
        confirmPassword.value,
      );
    }
  }

  void validateConfirmPassword(String value) {
    confirmPassword.value = value;
    confirmPasswordError.value = Validators.validateConfirmPassword(
      password.value,
      value,
    );
  }
}
