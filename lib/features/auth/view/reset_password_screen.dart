import 'package:chatter_box/core/widgets/custom_button.dart';
import 'package:chatter_box/core/widgets/custom_text_field.dart';
import 'package:chatter_box/features/auth/controllers/reset_password_controller.dart';
import 'package:chatter_box/features/auth/widgets/auth_header.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final resetPasswordController = Get.put(ResetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AuthHeader(
                title: 'Reset Password',
                subtitle:
                    'Enter your email to receive password reset instructions',
              ),

              // Email input
              Obx(
                () => CustomTextField(
                  hint: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) =>
                      resetPasswordController.email.value = value,
                  errorText: resetPasswordController.emailError.value,
                ),
              ),
              const SizedBox(height: 24),

              // Reset Password Button
              Obx(
                () => CustomButton(
                  text: 'Send Reset Link',
                  isLoading: resetPasswordController.isLoading.value,
                  onPressed: () => resetPasswordController.resetPassword()
                ),
              ),
              const SizedBox(height: 16),

              // Back to Sign In
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Remember your password? ",
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(
                        text: 'Sign In',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.back(); // go back to SignInScreen
                          },
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
