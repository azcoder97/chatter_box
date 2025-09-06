import 'package:chatter_box/features/auth/view/reset_password_screen.dart';
import 'package:chatter_box/features/auth/view/sign_in_screen.dart';
import 'package:chatter_box/features/auth/view/sign_up_screen.dart';
import 'package:chatter_box/routes/app_routes.dart';
import 'package:get/get.dart';

const Transition transition = Transition.cupertino;

class AppPages {
  ///
  /// Define Initial Screen Route
  ///
  // static const initial = AppRoutes.splashScreen;
  static const initial = AppRoutes.signInScreen;

  static final routes = [
    ///
    /// onbaoding
    ///
    // GetPage(
    //   name: AppRoutes.splashScreen,
    //   page: () => const SplashScreen(),
    //   transition: transition,
    // ),

    ///
    /// Auth
    ///
    GetPage(
      name: AppRoutes.signInScreen,
      page: () => const SignInScreen(),
      transition: transition,
    ),

    GetPage(
      name: AppRoutes.signUpScreen,
      page: () => const SignUpScreen(),
      transition: transition,
    ),

    GetPage(
      name: AppRoutes.resetPasswordScreen,
      page: () => const ResetPasswordScreen(),
      transition: transition,
    ),
  ];
}
