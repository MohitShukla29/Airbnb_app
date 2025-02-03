import 'package:get/get.dart';

class placeController extends GetxController {
  var currentIndex = 0.obs; // Observable variable

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}
