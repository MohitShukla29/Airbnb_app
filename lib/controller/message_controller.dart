import 'package:get/get.dart';

class MessageController extends GetxController{
  var selectedindex=0.obs;
  void changeIndex(int index){
    selectedindex.value=index;
  }
}