import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tn70snacks/tn70snacksapp/constants/app_colours.dart';
import 'package:tn70snacks/tn70snacksapp/controller/cart_controller.dart';
import 'package:tn70snacks/tn70snacksapp/controller/daily_needs_controller.dart';
import 'package:tn70snacks/tn70snacksapp/controller/favourite_controller.dart';

import '../../product_details/product_details_view.dart';

class DailyNeeds extends StatelessWidget {
  final DailyNeedsController controller = Get.put(DailyNeedsController());
  final FavouriteController wishlistController = Get.put(FavouriteController());
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 330,
      child: Obx(() => ListView.builder(
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        scrollDirection: Axis.horizontal,
        itemCount: controller.snacksList.length,
        itemBuilder: (context, index) {
          final snack = controller.snacksList[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 250,
              child: GestureDetector(
                onTap: () {
                  Get.to(() => ProductDetailsScreen(), arguments: snack);
                },
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromRGBO(240, 230, 250, 1),
                              ),
                              child: Image.asset(snack.Image, fit: BoxFit.contain),
                            ),
                            // Favourite button
                            Positioned(
                              top: 5,
                              right: 5,
                              child: Obx(() => Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Icon(
                                    wishlistController.isFavourite(snack)
                                        ? Icons.favorite
                                        : Icons.favorite_border_outlined,
                                    color: AppColors.primary,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    wishlistController.toggleFavourite(snack);
                                    Get.snackbar(wishlistController.isFavourite(snack) ? "Success" : "Removed",
                                      wishlistController.isFavourite(snack)
                                          ? "Item successfully added to favourite list"
                                          : "Item removed from favourite list",
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor:wishlistController.isFavourite(snack)?Colors.greenAccent:Colors.redAccent,
                                      colorText: Colors.white,
                                      margin: const EdgeInsets.all(10),
                                      duration: const Duration(seconds: 2),
                                    );
                                  },
                                ),
                              )),
                            ),
                            // Cart icon (optional action)
                            Positioned(
                              top: 45,
                              right: 5,
                              child: Obx(()=> Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                  ),
                                  child:IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: Icon(
                                      cartController.isAdded(snack)
                                          ? Icons.shopping_cart
                                          : Icons.shopping_cart_outlined,
                                      color: AppColors.primary,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      cartController.toggleCart(snack);
                                      Get.snackbar(
                                        cartController.isAdded(snack) ? "Success" : "Removed",
                                        cartController.isAdded(snack)
                                            ? "Item successfully added to cart"
                                            : "Item removed from cart",
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor:cartController.isAdded(snack)?Colors.greenAccent:Colors.redAccent,
                                        colorText: Colors.white,
                                        margin: const EdgeInsets.all(10),
                                        duration: const Duration(seconds: 2),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber),
                            SizedBox(width: 5),
                            Text("0.0"),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          snack.Snackname,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(snack.Quantity.toString()),
                            Text(
                              "₹${snack.Price}",
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      )),
    );
  }
}
