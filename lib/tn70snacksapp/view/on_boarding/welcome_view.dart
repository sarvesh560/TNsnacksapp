import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../constants/app_colours.dart';
import '../../constants/app_text_styles.dart';
import '../../constants/app_values.dart';
import '../../controller/welcome_controller.dart';
import '../../model/welcome_model.dart';
import '../auth/signin_view.dart';


class WelcomeScreen extends StatelessWidget {
  final WelcomeController controller = Get.put(WelcomeController());

  final List<WelcomeItem> welcomeList = [
    WelcomeItem(
      image: 'assets/images/shopping.jpg',
      title: 'Shop Grocery Without Stress',
      description: 'Quickly search and add healthy foods to your cart',
    ),
    WelcomeItem(
      image: 'assets/images/groceryimg.jpg',
      title: 'Amazing Discounts And Offers',
      description: 'Cheaper price than local supermarket, great discounts and cashbacks',
    ),
    WelcomeItem(
      image: 'assets/images/delivery.jpg',
      title: 'Express Delivery Within 10 Minutes',
      description: 'Fast delivery right to your doorstep',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CarouselSlider.builder(
                itemCount: welcomeList.length,
                itemBuilder: (context, index, realIdx) {
                  final item = welcomeList[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: media.width * 0.05),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(item.image, height: media.height * 0.35, fit: BoxFit.contain),
                        SizedBox(height: media.height * 0.05),
                        Text(item.title, textAlign: TextAlign.center, style: AppTextStyles.subHeadings),
                        SizedBox(height: 10),
                        Text(item.description,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.body.copyWith(color: Colors.black54)),
                      ],
                    ),
                  );
                },
                options: CarouselOptions(
                  height: media.height * 0.6,
                  autoPlay: true,
                  viewportFraction: 1.0,
                  onPageChanged: (index, _) => controller.changeIndex(index),
                ),
              ),
            ),

            // Dot Indicator
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(welcomeList.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: controller.currentIndex.value == index ? 12 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: controller.currentIndex.value == index
                        ? AppColors.primary
                        : Colors.grey[400],
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            )),

            const SizedBox(height: 24),

            // Skip & Get Started
            Padding(
              padding: EdgeInsets.symmetric(horizontal: media.width * 0.1),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(60),
                        backgroundColor: AppColors.buttonColor,
                        foregroundColor: AppColors.buttonTextColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppValues.borderRadius),
                        ),
                      ),
                      onPressed: () => Get.offAll(() => LoginScreen()),
                      child: const Text('GET STARTED', style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.offAll(() => LoginScreen()),
                    child: const Text("Skip", style: TextStyle(color: Colors.black54)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
