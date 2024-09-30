import 'package:get/get.dart';
import 'package:tasky_app/core/route/controller/route_controller.dart';

class SplashController extends GetxController {
  final RxDouble opacity = 0.0.obs;
  final RxDouble scale = 0.5.obs;
  final RouteController routeController = Get.put(RouteController());

  @override
  void onInit() {
    super.onInit();
    animateLogo();
  }

  void animateLogo() {
    Future.delayed(const Duration(milliseconds: 500), () {
      opacity.value = 1.0;
      scale.value = 1.0;
    });
  }
}
