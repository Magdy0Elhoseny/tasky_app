import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasky_app/core/helper/api/dependency_injection.dart';
import 'package:tasky_app/core/route/app_route.dart';
import 'package:tasky_app/core/route/controller/route_controller.dart';
import 'package:tasky_app/core/utils/local_database.dart';

import 'core/constants/app_constants.dart';
import 'core/helper/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  DependencyInjection.init();
  Get.put(RouteController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: AppStyels.appTheme,
      initialRoute: AppRoutes.configRoute,
      getPages: AppRoutes.getRoutes(),
    );
  }
}
