import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt selectedIndex = 0.obs;

  RxDouble xoffset = 0.0.obs;
  RxDouble yoffset = 0.0.obs;
  RxDouble scaleFactor = 1.0.obs;
  RxBool isOpen = false.obs;


  void toggleDrawer() {
    if (isOpen.value) {
      xoffset.value = 0;
      yoffset.value = 0;
      scaleFactor.value = 1;
      isOpen.value = false;
    } else {
      xoffset.value = 170;
      yoffset.value = 180;
      scaleFactor.value = 0.6;
      isOpen.value = true;
    }
  }

  void switchTo(int index) {
    selectedIndex.value = index;
    toggleDrawer();
  }

}
