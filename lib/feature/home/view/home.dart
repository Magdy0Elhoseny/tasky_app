import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tasky_app/core/asset%20manager/asset_manager.dart';
import 'package:tasky_app/core/helper/theme/app_theme.dart';
import 'package:tasky_app/core/route/app_route.dart';
import 'package:tasky_app/feature/home/Controller/home_controller.dart';
import 'package:tasky_app/feature/home/view/widgets/custom_appbar.dart';
import 'package:tasky_app/feature/home/view/widgets/qr_view.dart';
import 'package:tasky_app/feature/home/view/widgets/task_filter.dart';
import 'package:tasky_app/feature/home/view/widgets/task_list.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () => controller.fetchTasks(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppbar(controller: controller),
                const Text(
                  "My Tasks",
                  style: AppStyels.textStyle16W700,
                ),
                const SizedBox(height: 12),
                buildTaskFilter(),
                Expanded(
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return buildTaskList(controller);
                    }
                  }),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: 'qr',
              onPressed: () async {
                final result = await Get.to(() => const QRViewExample());
                if (result != null) {
                  Get.toNamed(AppRoutes.details, arguments: result);
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              child: SvgPicture.asset(AssetManager.qrIcon),
            ),
            const SizedBox(height: 20),
            FloatingActionButton(
              heroTag: 'addTask',
              onPressed: () {
                controller.goToAddTask();
              },
              backgroundColor: AppStyels.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
