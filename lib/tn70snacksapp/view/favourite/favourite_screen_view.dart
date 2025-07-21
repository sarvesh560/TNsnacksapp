import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tn70snacks/tn70snacksapp/constants/app_text_styles.dart';
import 'package:tn70snacks/tn70snacksapp/view/home/widgets/guest_guard_view.dart';
import '../../constants/app_colours.dart';
import '../../constants/app_values.dart';
import '../../controller/favourite_controller.dart';
import '../../controller/home_controller.dart';
import '../../controller/cart_controller.dart';
import '../product_details/product_details_view.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final HomeController homeController = Get.find<HomeController>();
    final FavouriteController favouriteController = Get.put(FavouriteController());
    final CartController cartController = Get.put(CartController());

    return GuestGuard(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('My Favourites', style: AppTextStyles.heading),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              size: AppValues.iconsSize,
              color: AppColors.primary,
            ),
            onPressed: () {
              homeController.switchTo(0);
            },
          ),
        ),
        body: Obx(() {
          if (favouriteController.favouriteList.isEmpty) {
            return Center(
              child: Text(
                'No favorite items yet.',
                style: AppTextStyles.subHeadings,
              ),
            );
          }

          return GridView.builder(
            itemCount: favouriteController.favouriteList.length,
            physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            padding: const EdgeInsets.all(AppValues.paddingMedium),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: size.width > 600 ? 3 : 2,
              mainAxisSpacing: AppValues.gapSmall,
              crossAxisSpacing: AppValues.gapSmall,
              childAspectRatio: 0.6,
            ),
            itemBuilder: (context, index) {
              final snack = favouriteController.favouriteList[index];
              return GestureDetector(
                onTap: () => Get.to(() => ProductDetailsScreen(), arguments: snack),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(AppValues.paddingSmall),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: size.height * 0.18,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(AppValues.radiusSmall),
                                color: const Color.fromRGBO(240, 230, 250, 1),
                              ),
                              child: Image.asset(snack.Image, fit: BoxFit.contain),
                            ),
                            Positioned(
                              top: 5,
                              right: 5,
                              child: GestureDetector(
                                onTap: () {
                                  favouriteController.toggleFavourite(snack);
                                  final isFav = favouriteController.isFavourite(snack);
                                  Get.snackbar(
                                    isFav ? "Added" : "Removed",
                                    isFav
                                        ? "Item added to favourite list"
                                        : "Item removed from favourite list",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor:
                                    isFav ? Colors.greenAccent : Colors.redAccent,
                                    colorText: Colors.white,
                                    margin: const EdgeInsets.all(AppValues.paddingSmall),
                                    duration: const Duration(seconds: 2),
                                  );
                                },
                                child: Obx(() => _iconBox(
                                  Icons.favorite,
                                  favouriteController.isFavourite(snack),
                                )),
                              ),
                            ),
                            Positioned(
                              top: 40,
                              right: 5,
                              child: GestureDetector(
                                onTap: () {
                                  cartController.toggleCart(snack);
                                  final isInCart = cartController.isAdded(snack);
                                  Get.snackbar(
                                    isInCart ? "Added to Cart" : "Removed from Cart",
                                    isInCart
                                        ? "Item added to cart"
                                        : "Item removed from cart",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor:
                                    isInCart ? Colors.greenAccent : Colors.redAccent,
                                    colorText: Colors.white,
                                    margin: const EdgeInsets.all(AppValues.paddingSmall),
                                    duration: const Duration(seconds: 2),
                                  );
                                },
                                child: Obx(() => _iconBox(
                                  cartController.isAdded(snack)
                                      ? Icons.shopping_cart
                                      : Icons.shopping_cart_outlined,
                                )),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppValues.gapSmall),
                        const Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            SizedBox(width: 4),
                            Text("0.0", style: AppTextStyles.labelSmall),
                          ],
                        ),
                        const SizedBox(height: AppValues.gapSmall),
                        Text(
                          snack.Snackname,
                          style: AppTextStyles.itemName,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          snack.Quantity.toString(),
                          style: AppTextStyles.itemSubtitle,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "₹${snack.Price}",
                          style: AppTextStyles.price,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }

  Widget _iconBox(IconData icon, [bool isFilled = false]) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppValues.radiusSmall),
        color: Colors.white,
      ),
      child: Icon(
        icon,
        size: 18,
        color: isFilled ? AppColors.primary : AppColors.primary,
      ),
    );
  }
}
