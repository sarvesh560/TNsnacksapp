import 'package:get/get.dart';
import 'package:tn70snacks/tn70snacksapp/model/snacks_model.dart';

class GridController extends GetxController {
  var isliked = false.obs;
  RxList<snacksModel> snacksList = <snacksModel>[].obs;

  @override
  void onInit() {
    loaddata();
    super.onInit();
  }

  void loaddata() {
    snacksList.value = <snacksModel>[
      snacksModel(id: '7', Image: "assets/images/mixture.png", Snackname: "Mixture (கார கலவை)", Price: 200.00, Quantity: "1.0 kg"),
      snacksModel(id: '8', Image: "assets/images/murukku2.png", Snackname: "Ribbon Murukku (ரிப்பன் முருகு)", Price: 150.00, Quantity: "1.0 kg"),
      snacksModel(id: '9', Image: "assets/images/murukku1.png", Snackname: "Murukku (முறுக்கு)", Price: 120.00, Quantity: "1 kg"),
      snacksModel(id: '10', Image: "assets/images/povadai.png", Snackname: "Poo Vadai (பூ வடை)", Price: 100.00, Quantity: "10.0 Pkg"),
      snacksModel(id: '11', Image: "assets/images/samosa.png", Snackname: "Samosa (சமோசா)", Price: 100.00, Quantity: "10.0 Pkg"),
      snacksModel(id: '12', Image: "assets/images/bread.png", Snackname: "Bread (ரொட்டி)", Price: 50.00, Quantity: "1.0 Pkg"),
      snacksModel(id: '13', Image: "assets/images/kamarcut.png", Snackname: "Kamarcut (கமார்கட்)", Price: 100.00, Quantity: "10.0 Pkg"),
      snacksModel(id: '14', Image: "assets/images/athirasam.png", Snackname: "Athirasam (அதிராசம்)", Price: 150.00, Quantity: "1.0 kg"),
      snacksModel(id: '15', Image: "assets/images/pakova.png", Snackname: "Palkova (பால்கோவா)", Price: 120.00, Quantity: "1 kg"),
      snacksModel(id: '16', Image: "assets/images/khozukottai.png", Snackname: "Kozhukattai (கொழுக்கட்டை)", Price: 100.00, Quantity: "10.0 Pkg"),
      snacksModel(id: '17', Image: "assets/images/sundal.png", Snackname: "Sundal (சுண்டல்)", Price: 50.00, Quantity: "100.0 gm"),
      snacksModel(id: '18', Image: "assets/images/kesari.png", Snackname: "Kesari (கேசரி)", Price: 50.00, Quantity: "1.0 Pkg"),
      snacksModel(id: '19', Image: "assets/images/arisibonda.png", Snackname: "Arisibonda (அரிசிபோண்டா)", Price: 100.00, Quantity: "10.0 Pkg"),
      snacksModel(id: '20', Image: "assets/images/bajibonda.png", Snackname: "Bajji (பஜ்ஜி)", Price: 150.00, Quantity: "1.0 kg"),
      snacksModel(id: '21', Image: "assets/images/meduvadai.png", Snackname: "Meduvadai (மெது வடை)", Price: 120.00, Quantity: "1 kg"),
      snacksModel(id: '22', Image: "assets/images/poriurundai.png", Snackname: "Pori Urundai (பொறி உருண்டை)", Price: 100.00, Quantity: "10.0 Pkg"),
      snacksModel(id: '23', Image: "assets/images/povadai.png", Snackname: "Poo Vadai (பூ வடை)", Price: 50.00, Quantity: "100.0 gm"),
      snacksModel(id: '24', Image: "assets/images/uppu seedai.png", Snackname: "Uppu Seedai (உப்பு சீடை)", Price: 50.00, Quantity: "1.0 Pkg"),
    ];
  }

  void togglefavourite() {
    isliked.value = !isliked.value;
  }
}
