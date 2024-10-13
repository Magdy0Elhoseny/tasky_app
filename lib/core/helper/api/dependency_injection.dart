import 'package:get/get.dart';
import 'package:tasky_app/core/helper/api/dio_configration.dart';

class DependencyInjection {
  static void init() {
    Get.lazyPut(() => DioConfig(), fenix: true);
  }
}
