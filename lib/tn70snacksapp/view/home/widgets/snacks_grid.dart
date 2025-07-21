import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tn70snacks/tn70snacksapp/constants/app_colours.dart';
import 'package:tn70snacks/tn70snacksapp/controller/grid_controller.dart';
import 'package:tn70snacks/tn70snacksapp/controller/favourite_controller.dart';
import '../../../controller/cart_controller.dart';
import '../../../model/snacks_model.dart';
import '../../product_details/product_details_view.dart';

class SnackGrid extends StatelessWidget {
  final GridController controller = Get.put(GridController());
  final FavouriteController favController = Get.put(FavouriteController());
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => GridView.builder(
        itemCount: controller.snacksList.length,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 10,
          childAspectRatio: 0.6,
        ),
        itemBuilder: (context, index) {
          final snack = controller.snacksList[index];

          return GestureDetector(
            onTap: () => Get.to(() => ProductDetailsScreen(), arguments: snack),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromRGBO(240, 230, 250, 1),
                          ),
                          child: Image.asset(snack.Image),
                        ),
                        Positioned(
                          top: 5,
                          right: 5,
                          child: GestureDetector(
                            onTap: () => _handleFavourite(snack),
                            child: Obx(() => _iconBox(
                              favController.isFavourite(snack)
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                            )),
                          ),
                        ),
                        Positioned(
                          top: 40,
                          right: 5,
                          child: GestureDetector(
                            onTap: () => _handleCart(snack),
                            child: Obx(() => _iconBox(
                              cartController.isAdded(snack)
                                  ? Icons.shopping_cart
                                  : Icons.shopping_cart_outlined,
                            )),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber),
                        SizedBox(width: 5),
                        Text("0.0"),
                      ],
                    ),
                    Text(
                      snack.Snackname,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(snack.Quantity.toString()),
                    Text(
                      "₹${snack.Price}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleFavourite(snacksModel snack) {
    favController.toggleFavourite(snack);
    final isFav = favController.isFavourite(snack);
    Get.snackbar(
      isFav ? "Success" : "Removed",
      isFav ? "Item successfully added to favourite list" : "Item removed from favourite list",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isFav ? Colors.greenAccent : Colors.redAccent,
      colorText: Colors.white,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 2),
    );
  }

  void _handleCart(snacksModel snack) {
    cartController.toggleCart(snack);
    cartController.calculateTotal();
    final isInCart = cartController.isAdded(snack);
    Get.snackbar(
      isInCart ? "Success" : "Removed",
      isInCart ? "Item successfully added to cart" : "Item removed from cart",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isInCart ? Colors.greenAccent : Colors.redAccent,
      colorText: Colors.white,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 2),
    );
  }

  Widget _iconBox(IconData icon, {Color color = AppColors.primary}) {
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
