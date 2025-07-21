import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tn70snacks/tn70snacksapp/constants/app_text_styles.dart';
import 'package:tn70snacks/tn70snacksapp/constants/app_colours.dart';
import 'package:tn70snacks/tn70snacksapp/constants/app_values.dart';
import 'package:tn70snacks/tn70snacksapp/controller/user_controller.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final UserController userController = Get.find();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final user = userController.user.value;
    if (user != null) {
      nameController.text = user.name ?? '';
      phoneController.text = user.phone ?? '';
      addressController.text = user.address ?? '';
    }

    // Optional: You can also listen to future updates if needed
    ever(userController.user, (user) {
      if (user != null) {
        nameController.text = user.name ?? '';
        phoneController.text = user.phone ?? '';
        addressController.text = user.address ?? '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Edit Profile", style: AppTextStyles.heading),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: AppValues.iconsSize,
            color: AppColors.primary,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        final user = userController.user.value;

        if (user == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: EdgeInsets.all(size.width * 0.05),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    await userController.uploadProfileImage();
                    Get.snackbar('Updated', 'Profile picture updated',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.greenAccent,
                      colorText: Colors.white,
                      margin: const EdgeInsets.all(AppValues.paddingSmall),
                      duration: const Duration(seconds: 2),
                    );
                  },
                  child: Center(
                    child: CircleAvatar(
                      radius: size.width * 0.15,
                      backgroundImage: user.profileImage != null
                          ? NetworkImage(user.profileImage!)
                          : null,
                      child: user.profileImage == null
                          ? const Icon(Icons.camera_alt, size: 40)
                          : null,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Name"),
                ),
                SizedBox(height: size.height * 0.015),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(labelText: "Phone"),
                ),
                SizedBox(height: size.height * 0.015),
                TextField(
                  controller: addressController,
                  maxLines: 2,
                  decoration: const InputDecoration(labelText: "Address"),
                ),
                SizedBox(height: size.height * 0.05),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(size.width, 50),
                    backgroundColor: AppColors.buttonColor,
                    foregroundColor: AppColors.buttonTextColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppValues.radiusMedium),
                    ),
                  ),
                  onPressed: () async {
                    if (nameController.text.trim().isEmpty ||
                        phoneController.text.trim().isEmpty ||
                        addressController.text.trim().isEmpty) {
                      Get.snackbar("Missing Fields", "Please fill all fields",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                        margin: const EdgeInsets.all(AppValues.paddingSmall),
                        duration: const Duration(seconds: 2),
                      );
                      return;
                    }

                    await userController.updateUser(
                      name: nameController.text.trim(),
                      phone: phoneController.text.trim(),
                      address: addressController.text.trim(),
                    );

                    Get.back();
                    Get.snackbar("Profile Updated", "Your profile has been updated successfully",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.greenAccent,
                      colorText: Colors.white,
                      margin: const EdgeInsets.all(AppValues.paddingSmall),
                      duration: const Duration(seconds: 2),);
                  },
                  child: const Text("Save Changes", style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

