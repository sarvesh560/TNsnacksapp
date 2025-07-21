import 'package:get/get.dart';
import 'package:tn70snacks/tn70snacksapp/model/snacks_model.dart';

class SearchController extends GetxController {
  final RxList<snacksModel> allSnacks = <snacksModel>[].obs;
  final RxList<snacksModel> filteredSnacks = <snacksModel>[].obs;
  final RxList<String> recentSearches = <String>[].obs;

  void setSnacks(List<snacksModel> snacks) {
    allSnacks.assignAll(snacks);
    filteredSnacks.assignAll(snacks);
  }

  void search(String query) {
    if (query.trim().isEmpty) {
      filteredSnacks.assignAll([]);
      return;
    }

    if (!recentSearches.contains(query)) {
      recentSearches.insert(0, query);
      if (recentSearches.length > 5) {
        recentSearches.removeLast();
      }
    }

    filteredSnacks.assignAll(
      allSnacks
          .where((snack) =>
          snack.Snackname.toLowerCase().contains(query.toLowerCase()))
          .toList(),
    );
  }

  void showRecent() {
    filteredSnacks.assignAll([]);
  }

  void searchFromRecent(String query) {
    search(query);
  }

  void clearRecent() {
    recentSearches.clear();
  }
}
