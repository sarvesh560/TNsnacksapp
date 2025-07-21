import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tn70snacks/tn70snacksapp/constants/app_text_styles.dart';
import '../../../constants/app_colours.dart';
import '../../../controller/auth_controller.dart';

class GuestGuard extends StatelessWidget {
  final Widget child;

  GuestGuard({required this.child});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Obx(() {
      if (authController.isGuestUser) {
        return Scaffold(
          appBar: AppBar(title: Text("Access Denied",style: AppTextStyles.heading,),
          centerTitle: true,
          ),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.lock, size: 80, color: Colors.grey),
                SizedBox(height: 20),
                Text(
                  "This feature is unavailable in Guest Mode.",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 50),
                    backgroundColor: AppColors.buttonColor,
                    foregroundColor: AppColors.buttonTextColor,
                    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    Get.offAllNamed('/login');
                  },
                  child: Text("Login to Continue"),
                )
              ],
            ),
          ),
        );
      }

      return child;
    });
  }
}
