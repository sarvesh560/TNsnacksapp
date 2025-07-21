import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tn70snacks/tn70snacksapp/controller/carousel_controller.dart';

class CarouselSliderWidget extends StatelessWidget {
  final carouselController controller = Get.put(carouselController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      width: double.infinity,
      child: Stack(
        children: [
          // Carousel
          CarouselSlider.builder(
            itemCount: controller.imageList.length,
            itemBuilder: (context, index, realIndex) {
               return Padding(
                 padding:  EdgeInsets.only(
                   left: 5,
                   right: 5,
                 ),
                 child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    controller.imageList[index],
                    fit: BoxFit.cover,
                    width: 400,
                    height: 200,
                  ),
                               ),
               );

            },
            options: CarouselOptions(
              height: 200,
              autoPlay: true,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                controller.updateIndex(index);
              },
            ),
          ),

          Obx(() => Positioned(
            bottom: 25,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: controller.imageList.asMap().entries.map((entry) {
                bool isActive = controller.currentIndex.value == entry.key;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: isActive ? 20 : 10,
                  height: isActive ? 20 : 10,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: isActive ? Color.fromRGBO(9, 51, 85, 1) : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                );
              }).toList(),
            ),
          )),
        ],
      ),
    );
  }
}
