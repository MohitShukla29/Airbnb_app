import 'package:airbnb_app/controller/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class DisplayTotalprice extends StatelessWidget {
  DisplayTotalprice({super.key});
  final CategoryController categoryController=Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),border: Border.all(color: Colors.black45)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Display total Price",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600),),
                  Text("Include all fees, before taxes",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black45),)
                ],
              ),
              Obx(()=>
                 Switch(inactiveThumbColor: Colors.white,inactiveTrackColor: Colors.grey,value: categoryController.isSwitch.value, onChanged: (value){
                  categoryController.switchButton(value);
                }),
              )
            ],
          ),
        ),
      ),);
  }
}
