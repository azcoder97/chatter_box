import 'package:chatter_box/features/auth/controllers/reset_password_controller.dart';
import 'package:chatter_box/features/auth/controllers/sign_in_controller.dart';
import 'package:chatter_box/features/auth/controllers/sign_up_controller.dart';
import 'package:chatter_box/features/auth/services/firebase_auth_service.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FirebaseAuthService());
    Get.lazyPut(() => SignUpController());
    Get.lazyPut(() => SignInController());
    Get.lazyPut(() => ResetPasswordController());
  }
}
