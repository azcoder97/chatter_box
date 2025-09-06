import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _box = GetStorage();
  final _key = 'themeMode';

  /// 0 = System, 1 = Light, 2 = Dark
  var themeIndex = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    themeIndex.value = _loadThemeFromBox();
  }

  ThemeMode get themeMode {
    switch (themeIndex.value) {
      case 1:
        return ThemeMode.light;
      case 2:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  void setTheme(int index) {
    themeIndex.value = index;
    _saveThemeToBox(index);
    Get.changeThemeMode(themeMode);
  }

  int _loadThemeFromBox() => _box.read(_key) ?? 0;

  void _saveThemeToBox(int index) => _box.write(_key, index);
}
