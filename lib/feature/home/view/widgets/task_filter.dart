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
      physics: const BouncingScrollPhysics(),
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
                            : AppStyels.secondaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Text(
                          controller.filterTypes[index],
                          style: isSelected
                              ? AppStyels.textStyle16W700
                                  .copyWith(color: Colors.white)
                              : AppStyels.textStyle16W400
                                  .copyWith(color: AppStyels.textColor),
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
