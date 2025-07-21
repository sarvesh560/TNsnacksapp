import 'package:get/get.dart';
import 'package:tn70snacks/tn70snacksapp/controller/daily_needs_controller.dart';
import 'package:tn70snacks/tn70snacksapp/controller/feautured_items_controller.dart';
import 'package:tn70snacks/tn70snacksapp/controller/grid_controller.dart';
import 'package:tn70snacks/tn70snacksapp/model/snacks_model.dart';

class DummyDataHelper {
  static List<snacksModel> getAllSnacks() {
    final dailyNeeds = Get.find<DailyNeedsController>().snacksList;
    final featured = Get.find<FeaturedItemsController>().snacksList;
    final grid = Get.find<GridController>().snacksList;

    final combined = [...dailyNeeds, ...featured, ...grid];

    final unique = {
      for (var snack in combined) snack.id: snack
    }.values.toList();

    return unique;
  }
}
