import 'package:chatter_box/core/bindings/theme_controller.dart';
import 'package:chatter_box/core/theme/app_theme.dart';
import 'package:chatter_box/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
