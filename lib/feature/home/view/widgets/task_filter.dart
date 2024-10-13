import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasky_app/feature/home/Controller/home_controller.dart';

import '../../../../core/helper/theme/app_theme.dart';

class HomeScreenFilter extends StatelessWidget {
  HomeScreenFilter({super.key});
  final HomeController controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Obx(() => Row(
            children: List.generate(
              controller.filterTypes.length,
              (index) {
                bool isSelected = controller.filterTypes[index] ==
                    controller.selectedFilter.value;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () =>
                        controller.setFilter(controller.filterTypes[index]),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppStyels.primaryColor
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Text(
                          controller.filterTypes[index],
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )),
    );
  }
}
