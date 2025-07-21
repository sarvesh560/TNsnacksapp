import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tn70snacks/tn70snacksapp/constants/app_colours.dart';
import 'package:tn70snacks/tn70snacksapp/constants/app_text_styles.dart';
import 'package:tn70snacks/tn70snacksapp/constants/app_values.dart';
import 'package:tn70snacks/tn70snacksapp/controller/search_controller.dart' as my;
import 'package:tn70snacks/tn70snacksapp/model/snacks_model.dart';
import 'package:tn70snacks/tn70snacksapp/routes/app_routes.dart';

class SearchScreen extends StatelessWidget {
  final List<snacksModel> snacksList;

  SearchScreen({super.key, required this.snacksList}) {
    if (Get.isRegistered<my.SearchController>()) {
      Get.delete<my.SearchController>();
    }
    final controller = Get.put(my.SearchController());
    controller.setSnacks(snacksList);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<my.SearchController>();
    final textController = TextEditingController();
    final media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        elevation: 2,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: AppValues.paddingSmall),
          child: Row(
            children: [
              Container(
                height: media.height * 0.06,
                width: media.width * 0.78,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  border: Border.all(color: AppColors.primary),
                  borderRadius: BorderRadius.circular(AppValues.radiusSmall),
                ),
                child: TextField(
                  controller: textController,
                  autofocus: true,
                  onChanged: (value) {
                    value.isEmpty
                        ? controller.showRecent()
                        : controller.search(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search snacks...',
                    hintStyle: AppTextStyles.view,
                    prefixIcon: Icon(Icons.search, color: Colors.grey.shade700),
                    suffixIcon: Obx(() => controller.filteredSnacks.isEmpty &&
                        controller.recentSearches.isNotEmpty
                        ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: controller.clearRecent,
                    )
                        : const SizedBox.shrink()),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Get.offAllNamed(AppRoutes.home),
                icon: const Icon(Icons.close_sharp),
              ),
            ],
          ),
        ),
      ),
      body: Obx(() {
        final results = controller.filteredSnacks;
        final recent = controller.recentSearches;

        if (results.isEmpty && recent.isNotEmpty && textController.text.isEmpty) {
          return ListView(
            padding: const EdgeInsets.all(AppValues.paddingMedium),
            children: [
              Text("Recent Searches", style: AppTextStyles.subHeadings),
              const SizedBox(height: AppValues.gapSmall),
              ...recent.map((query) => ListTile(
                leading: const Icon(Icons.history),
                title: Text(query, style: AppTextStyles.view),
                onTap: () {
                  textController.text = query;
                  controller.searchFromRecent(query);
                },
              )),
            ],
          );
        }

        if (results.isEmpty) {
          return const Center(child: Text("No snacks found"));
        }

        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final snack = results[index];
            return ListTile(
              onTap: () => Get.toNamed(AppRoutes.productDetails, arguments: snack),
              leading: Image.asset(snack.Image, width: 50, height: 50),
              title: Text(snack.Snackname, style: AppTextStyles.subHeadings),
              subtitle: Text('₹${snack.Price} • ${snack.Quantity}'),
            );
          },
        );
      }),
    );
  }
}
