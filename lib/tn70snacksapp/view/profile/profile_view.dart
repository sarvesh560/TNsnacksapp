import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tn70snacks/tn70snacksapp/constants/app_text_styles.dart';
import 'package:tn70snacks/tn70snacksapp/routes/app_routes.dart';
import '../../constants/app_colours.dart';
import '../../constants/app_values.dart';
import '../../controller/home_controller.dart';
import '../../controller/user_controller.dart';

class ProfileScreen extends StatelessWidget {
  final UserController userController = Get.put(UserController());
  final HomeController homeController = Get.find<HomeController>();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile', style: AppTextStyles.heading),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: AppValues.iconsSize,
            color: AppColors.primary,
          ),
          onPressed: () {
            Get.toNamed(AppRoutes.home);
          },
        ),
      ),
      body: Obx(() {
        final user = userController.user.value;

        if (user == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(AppValues.paddingLarge),
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  await userController.uploadProfileImage();
                  Get.snackbar('Updated', 'Profile picture updated');
                },
                child: CircleAvatar(
                  radius: media.width * 0.15,
                  backgroundImage: user.profileImage != null && user.profileImage!.isNotEmpty
                      ? NetworkImage(user.profileImage!)
                      : const AssetImage('assets/images/default_avatar.png') as ImageProvider,
                  child: user.profileImage == null || user.profileImage!.isEmpty
                      ? Icon(Icons.person, size: media.width * 0.1)
                      : null,
                ),
              ),
              SizedBox(height: media.height * 0.03),
              _infoTile(title: 'Name', value: user.name ?? 'Not set'),
              SizedBox(height: media.height * 0.015),
              _infoTile(title: 'Phone', value: user.phone ?? 'Not set'),
              SizedBox(height: media.height * 0.015),
              _infoTile(title: 'Address', value: user.address ?? 'Not set'),
              SizedBox(height: media.height * 0.05),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(media.width * 0.8, 50),
                  backgroundColor: AppColors.buttonColor,
                  foregroundColor: AppColors.buttonTextColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppValues.paddingLarge,
                    vertical: AppValues.paddingMedium,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppValues.radiusMedium),
                  ),
                ),
                onPressed: () => Get.toNamed('/edit-profile'),
                child: Text('Edit Profile',),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _infoTile({required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppValues.gapSmall),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title: ",
            style: AppTextStyles.loginlogout.copyWith(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.loginlogout.copyWith(
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
