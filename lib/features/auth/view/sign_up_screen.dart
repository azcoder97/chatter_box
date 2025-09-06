import 'package:chatter_box/core/widgets/custom_button.dart';
import 'package:chatter_box/core/widgets/custom_text_field.dart';
import 'package:chatter_box/features/auth/controllers/sign_up_controller.dart';
import 'package:chatter_box/features/auth/widgets/auth_header.dart';
import 'package:chatter_box/routes/app_routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  // Register controller once when screen is built
  final signUpController = Get.put(SignUpController());

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
                title: 'Create Account',
                subtitle: 'Sign up to get started',
              ),
              Obx(
                () => CustomTextField(
                  hint: 'Full Name',
                  keyboardType: TextInputType.name,
                  onChanged: (value) => signUpController.fullName.value = value,
                  errorText: signUpController.fullNameError.value,
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => CustomTextField(
                  hint: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => signUpController.email.value = value,
                  errorText: signUpController.emailError.value,
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => CustomTextField(
                  hint: 'Password',
                  obscureText: true,
                  onChanged: (value) => signUpController.password.value = value,
                  errorText: signUpController.passwordError.value,
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => CustomTextField(
                  hint: 'Confirm Password',
                  obscureText: true,
                  onChanged: (value) =>
                      signUpController.confirmPassword.value = value,
                  errorText: signUpController.confirmPasswordError.value,
                ),
              ),
              const SizedBox(height: 24),
              Obx(
                () => CustomButton(
                  text: 'Sign Up',
                  isLoading: signUpController.isLoading.value,
                  onPressed: () => signUpController.signUp(),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Already have an account? ",
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
                            Get.offAllNamed(AppRoutes.signInScreen);
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
