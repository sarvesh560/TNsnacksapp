import 'package:get/get.dart';
import 'package:tn70snacks/tn70snacksapp/model/snacks_model.dart';

class DailyNeedsController extends GetxController {
  RxList<snacksModel> snacksList = <snacksModel>[].obs;

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  void loadData() {
    snacksList.value = <snacksModel>[
      snacksModel(
        id: '23',
        Image: "assets/images/mixture.png",
        Snackname: "Mixture (கார கலவை)",
        Price: 200.00,
        Quantity: "1.0 kg",
      ),
      snacksModel(
        id: '24',
        Image: "assets/images/murukku2.png",
        Snackname: "Ribbon Murukku (ரிப்பன் முருகு)",
        Price: 150.00,
        Quantity: "1.0 kg",
      ),
      snacksModel(
        id: '25',
        Image: "assets/images/murukku1.png",
        Snackname: "Murukku (முறுக்கு)",
        Price: 120.00,
        Quantity: "1 kg",
      ),
      snacksModel(
        id: '26',
        Image: "assets/images/povadai.png",
        Snackname: "Poo Vadai (பூ வடை)",
        Price: 100.00,
        Quantity: "10.0 Pkg",
      ),
      snacksModel(
        id: '27',
        Image: "assets/images/samosa.png",
        Snackname: "Samosa (சமோசா)",
        Price: 100.00,
        Quantity: "10.0 Pkg",
      ),
      snacksModel(
        id: '28',
        Image: "assets/images/bread.png",
        Snackname: "Bread (ரொட்டி)",
        Price: 50.00,
        Quantity: "1.0 Pkg",
      ),
    ];
  }
}
