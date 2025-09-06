import 'package:chatter_box/features/auth/view/reset_password_screen.dart';
import 'package:chatter_box/features/auth/view/sign_in_screen.dart';
import 'package:chatter_box/features/auth/view/sign_up_screen.dart';
import 'package:chatter_box/features/chat/models/chat_screen_args.dart';
import 'package:chatter_box/features/chat/view/chat_list_screen.dart';
import 'package:chatter_box/features/chat/view/chat_screen.dart';
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
      page: () => SignInScreen(),
      transition: transition,
    ),

    GetPage(
      name: AppRoutes.signUpScreen,
      page: () => SignUpScreen(),
      transition: transition,
    ),

    GetPage(
      name: AppRoutes.resetPasswordScreen,
      page: () => ResetPasswordScreen(),
      transition: transition,
    ),
    GetPage(
      name: AppRoutes.chatListScreen,
      page: () => ChatListScreen(),
      transition: transition,
    ),

    GetPage(
      name: AppRoutes.chatScreen,
      page: () {
        final args = Get.arguments as ChatScreenArgs;
        return ChatScreen(userName: args.userName, avatarUrl: args.avatarUrl);
      },
      transition: transition,
    ),
  ];
}
