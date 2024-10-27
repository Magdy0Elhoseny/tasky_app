import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasky_app/core/helper/theme/app_theme.dart';
import 'package:tasky_app/feature/home/Controller/home_controller.dart';
import 'package:tasky_app/feature/home/view/widgets/custom_appbar.dart';
import 'package:tasky_app/feature/home/view/widgets/floating_actionsbuttons.dart';
import 'package:tasky_app/feature/home/view/widgets/task_filter.dart';
import 'package:tasky_app/feature/home/view/widgets/task_list.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    return Scaffold(
      floatingActionButton: FloatingActionsButtons(
        controller: controller,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            controller.resetPagination();
            await controller.fetchTasks();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppbar(controller: controller),
                    SizedBox(height: 18),
                    Text(
                      "My Tasks",
                      style: AppStyels.textStyle16W700
                          .copyWith(color: AppStyels.textColor),
                    ),
                    const SizedBox(height: 12),
                    HomeScreenFilter(),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value &&
                      controller.filteredTasks.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return TaskList(controller: controller);
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
