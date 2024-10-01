import 'package:get/get.dart';
import 'package:tasky_app/core/route/config_routing.dart';
import 'package:tasky_app/feature/auth/login/view/login_view.dart';
import 'package:tasky_app/feature/auth/register/view/register_view.dart';
import 'package:tasky_app/feature/auth/splash/view/splash_view.dart';
import 'package:tasky_app/feature/home/view/home.dart';
import 'package:tasky_app/feature/auth/onborading/view/onboarding_view.dart';

class AppRoutes {
  static const String configRoute = '/';
  static const String splash = '/splash';
  static const String onborading = '/onbording';
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';

  static List<GetPage> getRoutes() {
    return [
      GetPage(name: configRoute, page: () => const ConfigRouting()),
      GetPage(name: splash, page: () => const SplashView()),
      GetPage(name: onborading, page: () => const OnboardingView()),
      GetPage(name: login, page: () => const LoginView()),
      GetPage(name: register, page: () => const RegisterView()),
      GetPage(name: home, page: () => const HomeView()),
    ];
  }
}
