import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tn70snacks/tn70snacksapp/constants/app_colours.dart';
import 'package:tn70snacks/tn70snacksapp/constants/app_values.dart';
import 'package:tn70snacks/tn70snacksapp/controller/auth_controller.dart';
import 'package:tn70snacks/tn70snacksapp/controller/home_controller.dart';
import 'package:tn70snacks/tn70snacksapp/controller/user_controller.dart';
import 'package:tn70snacks/tn70snacksapp/routes/app_routes.dart';
import '../../profile/profile_view.dart';

class drawerView extends StatelessWidget {
  drawerView({super.key});

  final HomeController homeController = Get.put(HomeController());
  final UserController userController = Get.isRegistered<UserController>()
      ? Get.find<UserController>()
      : Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery
        .sizeOf(context)
        .height;
    double screenWidth = MediaQuery
        .sizeOf(context)
        .width;

    final user = userController.user.value;

    return Container(
      height: screenHeight,
      width: screenWidth,
      color: AppColors.primary,
      child: Material(
        color: Colors.transparent,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 10),
                child: IconButton(
                  onPressed: () {
                    homeController.toggleDrawer();
                  },
                  icon: Icon(Icons.close_sharp, color: AppColors.cartColor),
                ),
              ),

              /// Profile section
              GestureDetector(
                onTap: () {
                  if (user == null ||
                      (user.name?.isEmpty ?? true) ||
                      (user.phone?.isEmpty ?? true) ||
                      user.profileImage == null) {
                    Get.to(() => ProfileScreen(),
                        arguments: {'requireUpdate': true});
                  } else {
                    Get.to(() => ProfileScreen());
                  }
                },
                child: Padding(
                  padding:
                  const EdgeInsets.only(top: 40, left: 15, right: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                          child: (user != null &&
                              user.profileImage != null &&
                              user.profileImage!.isNotEmpty)
                              ? Image.network(
                            user.profileImage!,
                            fit: BoxFit.cover,
                            width: 50,
                            height: 50,
                            errorBuilder:
                                (context, error, stackTrace) =>
                                Icon(
                                  Icons.person,
                                  color: AppColors.cartColor,
                                  size: 30,
                                ),
                          )
                              : Icon(
                            Icons.person,
                            color: AppColors.cartColor,
                            size: 30,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user?.name?.isNotEmpty == true
                                  ? user!.name!
                                  : "Your Name",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                            Text(
                              user?.email ?? "your@email.com",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 13),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.notifications,
                          color: AppColors.cartColor,
                          size: AppValues.iconsSize),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 50),

              /// Menu list
              menuList(Icons.home_outlined, "Home", () {
                homeController.switchTo(0);
              }),
              menuList(Icons.favorite_border_outlined, "Favourites", () {
                homeController.switchTo(1);
              }),
              menuList(Icons.shopping_bag_outlined, "Shopping Bag", () {
                homeController.switchTo(2);
              }),
              menuList(Icons.note_add_outlined, "My Orders", () {
                homeController.switchTo(3);
              }),
              menuList(Icons.location_on_outlined, "Track Order", () {}),
              menuList(Icons.my_location_rounded, "Address", () {}),
              menuList(Icons.redeem_sharp, "Coupon", () {}),
              menuList(Icons.message_outlined, "Customer Support", () {}),
              menuList(Icons.settings_suggest_outlined, "Settings", () {}),
              menuList(Icons.account_balance_wallet_sharp, "Wallet", () {}),
              menuList(Icons.control_point_sharp, "Loyalty Point", () {}),
              menuList(Icons.note_add_outlined, "Terms & Conditions", () {}),
              menuList(Icons.privacy_tip_outlined, "Privacy Policy", () {}),
              menuList(Icons.account_circle_outlined, "About Us", () {}),
              menuList(Icons.event_note_outlined, "FAQ", () {}),
              menuList(Icons.logout_outlined, "Logout", () {
                Get.defaultDialog(
                  title: "Logout",
                  middleText: "Are you sure you want to logout?",
                  textConfirm: "Yes",
                  textCancel: "No",
                  confirmTextColor: Colors.white,
                  onConfirm: () {
                    Get.find<AuthController>().logout();
                  },
                  onCancel: () {
                    Get.back();
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget menuList(IconData icon, String iconname, VoidCallback ontap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white, size: AppValues.iconsSize),
      title: Text(iconname, style: const TextStyle(color: Colors.white)),
      onTap: ontap,
    );
  }
}