import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tn70snacks/tn70snacksapp/constants/app_text_styles.dart';
import 'package:tn70snacks/tn70snacksapp/model/snacks_model.dart';
import 'package:tn70snacks/tn70snacksapp/controller/cart_controller.dart';
import 'package:tn70snacks/tn70snacksapp/constants/app_colours.dart';
import 'package:tn70snacks/tn70snacksapp/constants/app_values.dart';

class ProductDetailsScreen extends StatelessWidget {
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    final snacksModel snack = Get.arguments;
    final media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Product Details", style: AppTextStyles.heading),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: AppValues.iconsSize,
            color: AppColors.primary,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Hero(
            tag: snack.id,
            child: Container(
              width: double.infinity,
              height: media.height * 0.35,
              margin: const EdgeInsets.all(AppValues.paddingMedium),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppValues.radiusLarge),
                color: AppColors.imageBackground,
              ),
              child: Center(
                child: Image.asset(
                  snack.Image,
                  width: media.width * 0.5,
                  height: media.width * 0.5,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          // Info Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppValues.paddingLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  snack.Snackname,
                  style: AppTextStyles.heading.copyWith(fontSize: 24),
                ),
                const SizedBox(height: AppValues.gapSmall),
                Text(
                  'Net Weight: ${snack.Quantity}',
                  style: AppTextStyles.view,
                ),
                const SizedBox(height: AppValues.gapSmall),
                Text(
                  'Price: ₹${snack.Price.toStringAsFixed(2)}',
                  style: AppTextStyles.subHeadings,
                ),
                const SizedBox(height: AppValues.gapLarge),
              ],
            ),
          ),
          const Spacer(),

          // Button
          Padding(
            padding: const EdgeInsets.all(AppValues.paddingLarge),
            child: Obx(() {
              final isInCart = cartController.isAdded(snack);
              return ElevatedButton.icon(
                icon: Icon(isInCart ? Icons.remove_shopping_cart : Icons.add_shopping_cart),
                label: Text(isInCart ? 'Remove from Cart' : 'Add to Cart'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isInCart ? Colors.red : AppColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, media.height * 0.07),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppValues.radiusMedium),
                  ),
                ),
                onPressed: () {
                  cartController.toggleCart(snack);
                  final message = isInCart
                      ? "${snack.Snackname} removed from cart"
                      : "${snack.Snackname} added to cart";
                  Get.snackbar(
                    isInCart ? "Removed" : "Success",
                    message,
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: isInCart ? Colors.red : Colors.green,
                    colorText: Colors.white,
                    margin: const EdgeInsets.all(AppValues.paddingMedium),
                    duration: const Duration(seconds: 2),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
