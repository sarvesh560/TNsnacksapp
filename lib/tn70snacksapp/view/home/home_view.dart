import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tn70snacks/tn70snacksapp/constants/app_colours.dart';
import 'package:tn70snacks/tn70snacksapp/constants/app_text_styles.dart';
import 'package:tn70snacks/tn70snacksapp/constants/app_values.dart';
import 'package:tn70snacks/tn70snacksapp/controller/cart_controller.dart';
import 'package:tn70snacks/tn70snacksapp/controller/home_controller.dart';
import 'package:tn70snacks/tn70snacksapp/routes/app_routes.dart';
import 'package:tn70snacks/tn70snacksapp/view/home/snacks_view.dart';
import 'package:tn70snacks/tn70snacksapp/view/home/widgets/carousel_view.dart';
import 'package:tn70snacks/tn70snacksapp/view/home/widgets/daily_needs_view.dart';
import 'package:tn70snacks/tn70snacksapp/view/home/widgets/drawer_view.dart';
import 'package:tn70snacks/tn70snacksapp/view/home/widgets/featured_items_view.dart';
import 'package:tn70snacks/tn70snacksapp/view/home/widgets/snacks_grid.dart';
import '../../../helper/dummy_data.dart';
import '../auth/signin_view.dart';
import '../cart/cart_view.dart';
import '../favourite/favourite_screen_view.dart';
import '../order/order_view.dart';
import '../search/search_view.dart';

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());
  final CartController cartController = Get.put(CartController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Stack(
      children: [
        drawerView(),
        Obx(() => AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          transform: Matrix4.translationValues(
            controller.xoffset.value,
            controller.yoffset.value,
            0,
          )..scale(controller.scaleFactor.value),
          child: ClipRRect(
            borderRadius: controller.isOpen.value
                ? BorderRadius.circular(AppValues.radiusLarge)
                : BorderRadius.zero,
            child: Obx(() => Stack(
              children: [
                Offstage(
                  offstage: controller.selectedIndex.value != 0,
                  child: _buildHomeContent(media),
                ),
                Offstage(
                  offstage: controller.selectedIndex.value != 1,
                  child: FavoriteScreen(),
                ),
                Offstage(
                  offstage: controller.selectedIndex.value != 2,
                  child: CartScreen(),
                ),
                Offstage(
                  offstage: controller.selectedIndex.value != 3,
                  child: OrderView(),
                ),
                Offstage(
                  offstage: controller.selectedIndex.value != 4,
                  child: LoginScreen(),
                )
              ],
            )),
          ),
        )),
      ],
    );
  }

  Widget _buildHomeContent(Size media) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TN Snacks", style: AppTextStyles.heading),
        centerTitle: true,
        leading: IconButton(
          onPressed: controller.toggleDrawer,
          icon: Icon(Icons.category_sharp,
              size: AppValues.iconsSize, color: AppColors.primary),
        ),
        actions: [
          IconButton(
            onPressed: () {
              final snacks = DummyDataHelper.getAllSnacks();
              Get.to(() => SearchScreen(snacksList: snacks));
            },
            icon: Icon(Icons.search,
                size: AppValues.iconsSize, color: AppColors.primary),
          ),
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.cart);
                },
                icon: Icon(Icons.shopping_cart_outlined,
                    size: AppValues.iconsSize, color: AppColors.cartColor),
              ),
              Positioned(
                top: 6,
                right: 6,
                child: Obx(() => cartController.count > 0
                    ? Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  constraints:
                  const BoxConstraints(minWidth: 20, minHeight: 20),
                  child: Center(
                    child: Text(
                      '${cartController.count}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
                    : const SizedBox.shrink()),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppValues.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppValues.gapMedium),
            SizedBox(height: media.height * 0.25, child: CarouselSliderWidget()),

            // Daily Needs Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Daily Needs", style: AppTextStyles.subHeadings),
                GestureDetector(
                  onTap: () {
                    Get.to(SnackGridScreen(),
                        duration: const Duration(milliseconds: 1500));
                  },
                  child: Text("View All", style: AppTextStyles.view),
                ),
              ],
            ),
            SizedBox(height: media.height * 0.4, child: DailyNeeds()),
            const SizedBox(height: AppValues.gapMedium),

            // Featured Items Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Featured Items", style: AppTextStyles.subHeadings),
                GestureDetector(
                  onTap: () {
                    Get.to(SnackGridScreen(),
                        duration: const Duration(milliseconds: 1500));
                  },
                  child: Text("View All", style: AppTextStyles.view),
                ),
              ],
            ),
            SizedBox(height: media.height * 0.3, child: FeatureItems()),
            const SizedBox(height: AppValues.gapMedium),

            // All Items
            GestureDetector(
              onTap: () => Get.to(SnackGridScreen()),
              child: Text("All Items", style: AppTextStyles.subHeadings),
            ),
            SnackGrid(),
          ],
        ),
      ),
    );
  }
}
