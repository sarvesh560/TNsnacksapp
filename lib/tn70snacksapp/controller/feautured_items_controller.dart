import 'package:get/get.dart';
import 'package:tn70snacks/tn70snacksapp/model/snacks_model.dart';

class FeaturedItemsController extends GetxController {
  RxList<snacksModel> snacksList = <snacksModel>[].obs;

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  void loadData() {
    snacksList.value = <snacksModel>[
      snacksModel(
        id: '1',
        Image: "assets/images/kamarcut.png",
        Snackname: "Kamarcut (கமார்கட்)",
        Price: 100.00,
        Quantity: "10.0 Pkg",
      ),
      snacksModel(
        id: '2',
        Image: "assets/images/athirasam.png",
        Snackname: "Athirasam (அதிராசம்)",
        Price: 150.00,
        Quantity: "1.0 kg",
      ),
      snacksModel(
        id: '3',
        Image: "assets/images/pakova.png",
        Snackname: "Palkova (பால்கோவா)",
        Price: 120.00,
        Quantity: "1 kg",
      ),
      snacksModel(
        id: '4',
        Image: "assets/images/khozukottai.png",
        Snackname: "Kozhukattai (கொழுக்கட்டை)",
        Price: 100.00,
        Quantity: "10.0 Pkg",
      ),
      snacksModel(
        id: '5',
        Image: "assets/images/sundal.png",
        Snackname: "Sundal (சுண்டல்)",
        Price: 50.00,
        Quantity: "100.0 gm",
      ),
      snacksModel(
        id: '6',
        Image: "assets/images/kesari.png",
        Snackname: "Kesari (கேசரி)",
        Price: 50.00,
        Quantity: "1.0 Pkg",
      ),
    ];
  }
}
