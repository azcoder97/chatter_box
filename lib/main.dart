import 'package:chatter_box/core/bindings/theme_controller.dart';
import 'package:chatter_box/core/theme/app_theme.dart';
import 'package:chatter_box/features/auth/view/sign_in_screen.dart';
import 'package:chatter_box/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // 🔥 initialize before running app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        getPages: AppPages.routes,
        initialRoute: AppPages.initial,
        debugShowCheckedModeBanner: false,
        title: 'ChatterBox',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeController.themeMode,
      );
    });
  }
}
