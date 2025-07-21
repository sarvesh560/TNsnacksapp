import 'package:get/get.dart';

class carouselController extends GetxController{
  RxList<String> imageList = <String>[].obs;
  var currentIndex = 0.obs;

  @override
  void onInit(){
    loadaImages();
    super.onInit();
  }

  void loadaImages(){
    imageList.value=[
      "assets/images/banner1.png",
      "assets/images/banner2.png",
      "assets/images/banner3.png",
      "assets/images/banner4.jpg",
    ];
  }

  void updateIndex(int index){
    currentIndex.value=index;
  }
}