import 'package:get/get.dart';
import 'package:tasky_app/core/route/controller/route_controller.dart';

class OnboardingController extends GetxController {
  final RouteController routeController = Get.find<RouteController>();

  void onGetStarted() {
    routeController.goToLogin();
  }
}
