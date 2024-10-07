import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasky_app/feature/home/Controller/home_controller.dart';
import 'package:tasky_app/feature/home/view/widgets/filter_chip.dart';

Widget buildTaskFilter() {
  final HomeController controller = Get.find<HomeController>();
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Obx(() => Row(
          children: [
            filterChip('All', controller.selectedFilter.value == 'All'),
            filterChip(
                'Inprogress', controller.selectedFilter.value == 'Inprogress'),
            filterChip('Waiting', controller.selectedFilter.value == 'Waiting'),
            filterChip(
                'Finished', controller.selectedFilter.value == 'Finished'),
          ],
        )),
  );
}
