import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tn70snacks/tn70snacksapp/constants/app_colours.dart';
import 'package:tn70snacks/tn70snacksapp/constants/app_text_styles.dart';
import 'package:tn70snacks/tn70snacksapp/constants/app_values.dart';
import 'package:tn70snacks/tn70snacksapp/controller/cart_controller.dart';
import 'package:tn70snacks/tn70snacksapp/controller/home_controller.dart';
import 'package:tn70snacks/tn70snacksapp/routes/app_routes.dart';
import 'package:tn70snacks/tn70snacksapp/view/home/widgets/guest_guard_view.dart';

class CartScreen extends StatelessWidget {
  final CartController cartController = Get.find<CartController>();
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GuestGuard(
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Cart', style: AppTextStyles.heading.copyWith(fontSize: size.width * 0.065)),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              size: size.width * 0.05,
              color: AppColors.primary,
            ),
            onPressed: () {
              homeController.switchTo(0);
              Get.toNamed(AppRoutes.home);
            },
          ),
        ),
        body: Obx(() {
          if (cartController.cartList.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Your cart is empty",
                      style: AppTextStyles.caption.copyWith(fontSize: size.width * 0.055),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: size.height * 0.03),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonColor,
                        foregroundColor: AppColors.buttonTextColor,
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.08,
                          vertical: size.height * 0.018,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppValues.radiusMedium),
                        ),
                      ),
                      onPressed: () {
                        homeController.switchTo(0);
                        Get.offAllNamed(AppRoutes.home);
                      },
                      child: Text("Let's Shop", style: TextStyle(fontSize: size.width * 0.045)),
                    ),
                  ],
                ),
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartController.cartList.length,
                  itemBuilder: (context, index) {
                    final snack = cartController.cartList[index];
                    return Card(
                      margin: EdgeInsets.symmetric(
                        horizontal: size.width * 0.05,
                        vertical: size.height * 0.008,
                      ),
                      child: ListTile(
                        leading: Image.asset(snack.Image, width: size.width * 0.13, height: size.width * 0.13),
                        title: Text(snack.Snackname, style: AppTextStyles.itemName),
                        subtitle: Text("${snack.Quantity} • ₹${snack.Price}", style: AppTextStyles.itemSubtitle),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => cartController.removeFromCart(snack),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(size.width * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => Text(
                      "Total: ₹${cartController.totalAmount.value.toStringAsFixed(2)}",
                      style: AppTextStyles.subHeadings.copyWith(fontSize: size.width * 0.05),
                    )),
                    SizedBox(height: size.height * 0.02),
                    SizedBox(
                      width: double.infinity,
                      height: size.height * 0.07,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.buttonColor,
                          foregroundColor: AppColors.buttonTextColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppValues.radiusMedium),
                          ),
                        ),
                        onPressed: () {
                          cartController.placeOrder();
                          Get.snackbar(
                            "Order Placed",
                            "Your order has been placed successfully",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                          );
                        },
                        child: Text("Place Order", style: TextStyle(fontSize: size.width * 0.045)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
