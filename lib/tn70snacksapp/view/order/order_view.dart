import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tn70snacks/tn70snacksapp/constants/app_text_styles.dart';
import 'package:tn70snacks/tn70snacksapp/controller/cart_controller.dart';
import 'package:tn70snacks/tn70snacksapp/controller/home_controller.dart';
import 'package:tn70snacks/tn70snacksapp/routes/app_routes.dart';
import 'package:tn70snacks/tn70snacksapp/view/home/widgets/guest_guard_view.dart';
import '../../constants/app_colours.dart';
import '../../constants/app_values.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController orderController = Get.put(CartController());
    final HomeController controller = Get.put(HomeController());

    return GuestGuard(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('My Orders', style: AppTextStyles.heading),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              size: AppValues.iconsSize,
              color: AppColors.primary,
            ),
            onPressed: () {
              controller.switchTo(0);
              Get.back();
            },
          ),
        ),
        body: Obx(() {
          if (orderController.orders.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Buy something to see your orders here"),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonColor,
                      foregroundColor: AppColors.buttonTextColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppValues.radiusMedium),
                      ),
                    ),
                    onPressed: () {
                      Get.offAllNamed(AppRoutes.home);
                    },
                    child: const Text("Let's Shop"),
                  )
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: orderController.orders.length,
            padding: const EdgeInsets.all(12),
            itemBuilder: (context, index) {
              final order = orderController.orders[index];
              final List items = order['items'] ?? [];

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Order ID: ${order['id']}", style: AppTextStyles.subHeadings),
                      const SizedBox(height: 6),
                      Text(
                        "Items: ${items.map((e) => e['Snackname']).join(', ')}",
                        style: AppTextStyles.subHeadings,
                      ),
                      const SizedBox(height: 6),
                      Text("Date: ${order['date']}", style: AppTextStyles.subHeadings),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total: ₹${order['total']}", style: AppTextStyles.subHeadings),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: _getStatusColor(order['status']),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              order['status'],
                              style: AppTextStyles.subHeadings.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'Delivered':
        return Colors.green;
      case 'Out for Delivery':
        return Colors.orange;
      case 'Pending':
        return Colors.red;
      default:
        return AppColors.primary;
    }
  }
}


