import 'package:chatter_box/core/widgets/custom_button.dart';
import 'package:chatter_box/core/widgets/custom_text_field.dart';
import 'package:chatter_box/features/auth/controllers/sign_in_controller.dart';
import 'package:chatter_box/features/auth/widgets/auth_header.dart';
import 'package:chatter_box/routes/app_routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final signInController = Get.put(SignInController());

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
                title: 'Welcome Back',
                subtitle: 'Sign in to continue',
              ),
              Obx(
                () => CustomTextField(
                  hint: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => signInController.email.value = value,
                  errorText: signInController.emailError.value,
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => CustomTextField(
                  hint: 'Password',
                  obscureText: true,
                  onChanged: (value) => signInController.password.value = value,
                  errorText: signInController.passwordError.value,
                ),
              ),
              const SizedBox(height: 16),
              // Forgot Password link
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Get.offAllNamed(AppRoutes.resetPasswordScreen);
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
              Obx(
                () => CustomButton(
                  text: 'Sign In',
                  isLoading: signInController.isLoading.value,
                  onPressed: () => signInController.signIn(),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium, // default text style
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.offAllNamed(AppRoutes.signUpScreen);
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
