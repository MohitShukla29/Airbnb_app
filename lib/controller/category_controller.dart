import 'package:get/get.dart';

class CategoryController extends GetxController {
  var selectedCategoryIndex = 0.obs;
  var isSwitch=false.obs;
  void changeCategory(int index) {
    selectedCategoryIndex.value = index;
  }

  void switchButton(bool ans) {
    isSwitch.value = ans;
  }
}
