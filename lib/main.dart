import 'package:chatter_box/core/bindings/theme_controller.dart';
import 'package:chatter_box/features/auth/services/firebase_auth_service.dart';
import 'package:chatter_box/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // 🔥 initialize before running app
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // ✅ Make FirebaseAuthService globally available
  Get.put(FirebaseAuthService(), permanent: true);
  // App-wide controller
  Get.put(ThemeController());

  runApp(MyApp());
}
