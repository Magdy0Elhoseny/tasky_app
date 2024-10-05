import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tasky_app/core/helper/theme/app_theme.dart';
import 'package:tasky_app/feature/Profile/controller/profile_controller.dart';
import '../../../core/asset manager/asset_manager.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          leading: IconButton(
            icon: SvgPicture.asset(AssetManager.arrowBackIcon),
            onPressed: () => Get.back(),
          ),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.profile.value != null) {
            final profile = controller.profile.value!;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildInfoItem('NAME', profile.displayName),
                  _infoItem('PHONE', profile.username),
                  _buildInfoItem('LEVEL', profile.level),
                  _buildInfoItem('YEARS OF EXPERIENCE',
                      '${profile.experienceYears} years'),
                  _buildInfoItem('LOCATION', profile.address),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Failed to load profile'));
          }
        }),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppStyels.textfeildColor.withOpacity(0.25),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Text(label),
          titleTextStyle: AppStyels.textStyleHint12W500
              .copyWith(color: AppStyels.textColor),
          subtitle: Text(value),
          subtitleTextStyle: AppStyels.textStyle18W700
              .copyWith(color: AppStyels.textColor.withOpacity(0.6)),
        ),
      ),
    );
  }

  Widget _infoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppStyels.textfeildColor.withOpacity(0.25),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Text(label),
          titleTextStyle: AppStyels.textStyleHint12W500
              .copyWith(color: AppStyels.textColor),
          subtitle: Text(value),
          subtitleTextStyle: AppStyels.textStyle18W700
              .copyWith(color: AppStyels.textColor.withOpacity(0.6)),
          trailing: IconButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: value));
              Get.snackbar('Copied', '$label copied to clipboard');
            },
            icon: SvgPicture.asset(AssetManager.copyIcon),
          ),
        ),
      ),
    );
  }
}

// Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
//           const SizedBox(height: 4),
//           Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//         ],
//       ),