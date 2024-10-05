import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky_app/core/asset%20manager/asset_manager.dart';
import 'package:tasky_app/feature/home/Controller/home_controller.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key, required this.controller});
  final HomeController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SvgPicture.asset(AssetManager.logo),
          const Spacer(),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  controller.goToProfile();
                },
                child: SvgPicture.asset(AssetManager.profileIcon),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                  onTap: () {
                    controller.logOut();
                  },
                  child: SvgPicture.asset(AssetManager.logoutIcon)),
            ],
          )
        ],
      ),
    );
  }
}
