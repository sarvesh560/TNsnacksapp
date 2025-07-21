import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tn70snacks/tn70snacksapp/controller/feautured_items_controller.dart';
import 'package:tn70snacks/tn70snacksapp/controller/favourite_controller.dart';
import 'package:tn70snacks/tn70snacksapp/constants/app_colours.dart';
import '../../../controller/cart_controller.dart';
import '../../product_details/product_details_view.dart';

class FeatureItems extends StatelessWidget {
  final FeaturedItemsController controller = Get.put(FeaturedItemsController());
  final FavouriteController favController = Get.put(FavouriteController());
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Obx(() => ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.snacksList.length,
        itemBuilder: (context, index) {
          final snack = controller.snacksList[index];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 350,
              child: GestureDetector(
                onTap: () {
                  Get.to(() => ProductDetailsScreen(), arguments: snack);
                },
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 130,
                              width: 130,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(255, 225, 243, 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.asset(
                                snack.Image,
                                fit: BoxFit.cover,
                                width: 80,
                                height: 80,
                              ),
                            ),
                            Positioned(
                              top: 5,
                              right: 5,
                              child: Obx(() {
                                return GestureDetector(
                                  onTap: () {
                                    cartController.toggleCart(snack);
                                    cartController.calculateTotal();
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
                                  child: _iconBox(
                                    cartController.isAdded(snack)
                                        ? Icons.shopping_cart
                                        : Icons.shopping_cart_outlined,
                                    color: AppColors.primary,
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(Icons.star, color: Colors.amber, size: 18),
                                      SizedBox(width: 5),
                                      Text("0.0"),
                                    ],
                                  ),
                                  Obx(() {
                                    return GestureDetector(
                                      onTap: () {
                                        favController.toggleFavourite(snack);
                                        Get.snackbar(favController.isFavourite(snack) ? "Success" : "Removed",
                                          favController.isFavourite(snack)
                                              ? "Item successfully added to favourite list"
                                              : "Item removed from favourite list",
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor:favController.isFavourite(snack)?Colors.greenAccent:Colors.redAccent,
                                          colorText: Colors.white,
                                          margin: const EdgeInsets.all(10),
                                          duration: const Duration(seconds: 2),
                                        );
                                      },
                                      child: _iconBox(
                                        favController.isFavourite(snack)
                                            ? Icons.favorite
                                            : Icons.favorite_border_outlined,
                                        color: AppColors.primary,
                                      ),
                                    );
                                  }),
                                ],
                              ),
                              Text(
                                snack.Snackname,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(snack.Quantity.toString()),
                              Text("₹${snack.Price}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 16)),
                            ],
                          ),
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

  static Widget _iconBox(IconData icon,
      {Color color = const Color.fromRGBO(9, 51, 85, 1)}) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Icon(icon, size: 18, color: color),
    );
  }
}
