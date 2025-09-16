import 'package:chatter_box/features/auth/services/firebase_auth_service.dart';
import 'package:chatter_box/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Get.find<FirebaseAuthService>();
    return Scaffold(
      body: Center(
        child: StreamBuilder(
          stream: authService.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            final user = snapshot.data;
            // ✅ If logged in → Go to HomeScreen
            if (user != null) {
              Future.microtask(() => Get.offAllNamed(AppRoutes.chatListScreen));
            } else {
              // 🚪 Not logged in → Go to SignIn
              Future.microtask(() => Get.offAllNamed(AppRoutes.signInScreen));
            }

            // Just show splash while navigation happens
            return const FlutterLogo(size: 100);
          },
        ),
      ),
    );
  }
}
