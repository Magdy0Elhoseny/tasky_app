import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tasky_app/core/asset%20manager/asset_manager.dart';
import 'package:tasky_app/core/helper/theme/app_theme.dart';
import 'package:tasky_app/feature/home/Controller/home_controller.dart';
import 'package:tasky_app/feature/home/view/widgets/custom_appbar.dart';
import 'package:tasky_app/feature/home/view/widgets/task_list_item.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    return SafeArea(
      child: Scaffold(
        body: Padding(
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
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: 'qr',
              onPressed: () {},
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
              // materialTapTargetSize: MaterialTapTargetSize.values[1],
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

  Widget buildTaskFilter() {
    final HomeController controller = Get.find<HomeController>();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Obx(() => Row(
            children: [
              filterChip('All', controller.selectedFilter.value == 'All'),
              filterChip('Inprogress',
                  controller.selectedFilter.value == 'Inprogress'),
              filterChip(
                  'Waiting', controller.selectedFilter.value == 'Waiting'),
              filterChip(
                  'Finished', controller.selectedFilter.value == 'Finished'),
            ],
          )),
    );
  }

  Widget filterChip(String label, bool isSelected) {
    final HomeController controller = Get.find<HomeController>();
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () => controller.setFilter(label),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? AppStyels.primaryColor : Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTaskList(HomeController controller) {
    return Obx(() => ListView.builder(
          shrinkWrap: true,
          itemCount: controller.filteredTasks.length,
          itemBuilder: (context, index) {
            final task = controller.filteredTasks[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TaskItem(task: task),
            );
          },
        ));
  }
}
