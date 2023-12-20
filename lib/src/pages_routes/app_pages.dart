import 'package:app_quitanda/src/pages/auth/sign_in_screen.dart';
import 'package:app_quitanda/src/pages/auth/sign_up_screen.dart';
import 'package:app_quitanda/src/pages/base/base_screen.dart';
import 'package:app_quitanda/src/pages/splash/splash_screen.dart';
import 'package:get/get.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: PagesRoutes.splashRoute,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: PagesRoutes.sigInRoute,
      page: () => const SignInScreen(),
    ),
    GetPage(
      name: PagesRoutes.sigUpRoute,
      page: () => SignUpScreen(),
    ),
    GetPage(
      name: PagesRoutes.baseRoute,
      page: () => const BaseScreen(),
    ),
  ];
}

abstract class PagesRoutes {
  static const String splashRoute = "/splash";
  static const String sigInRoute = "/signin";
  static const String sigUpRoute = "/signup";
  static const String baseRoute = "/";
}
