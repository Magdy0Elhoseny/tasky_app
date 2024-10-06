import 'package:get/get.dart';
import 'package:tasky_app/core/route/config_routing.dart';
import 'package:tasky_app/feature/Profile/controller/profile_controller.dart';
import 'package:tasky_app/feature/Profile/views/profile_view.dart';
import 'package:tasky_app/feature/Task%20Details/controller/details_controller.dart';
import 'package:tasky_app/feature/Task%20Details/views/details_view.dart';
import 'package:tasky_app/feature/add%20task/views/add_task_view.dart';
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
  static const String addTask = '/addTask';
  static const String profile = '/profile';
  static const String details = '/details';
  static List<GetPage> getRoutes() {
    return [
      GetPage(name: configRoute, page: () => const ConfigRouting()),
      GetPage(name: splash, page: () => const SplashView()),
      GetPage(name: onborading, page: () => const OnboardingView()),
      GetPage(name: login, page: () => const LoginView()),
      GetPage(name: register, page: () => const RegisterView()),
      GetPage(name: home, page: () => const HomeView()),
      GetPage(
        name: addTask,
        page: () => const AddTaskView(),
        binding: AddTaskBinding(),
      ),
      GetPage(
        name: profile,
        page: () => const ProfileView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ProfileController());
        }),
      ),
      GetPage(
        name: details,
        page: () => const DetailsView(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => DetailsController());
        }),
      ),
    ];
  }
}
