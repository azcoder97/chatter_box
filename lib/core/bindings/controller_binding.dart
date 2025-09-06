import 'package:chatter_box/core/bindings/theme_controller.dart';
import 'package:get/get.dart';

///
/// Initial Controller Binding
///
class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    // Theme controller initialisation
    Get.put(ThemeController());
  }
}
