import 'package:airbnb_app/components/display_totalprice.dart';
import 'package:airbnb_app/components/map_button.dart';
import 'package:airbnb_app/components/Display_place.dart';
import 'package:airbnb_app/components/search_bar.dart';
import 'package:airbnb_app/controller/mainpage_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/category_controller.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({super.key});
  final CategoryController categoryController=Get.put(CategoryController());
  final CollectionReference categoryCollection =
      FirebaseFirestore.instance.collection("categoryCollection");
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SearchBarandFilter(),
            StreamBuilder(
                stream: categoryCollection.snapshots(),
                builder: (context, streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    return Stack(
                      children: [
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 80,
                          child: Divider(
                            color: Colors.black12,
                          ),
                        ),
                        SizedBox(
                          height: size.height * .12,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: streamSnapshot.data!.docs.length,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap:()=> categoryController.changeCategory(index),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 20, right: 20, top: 20),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Obx(()=>
                                       Column(
                                        children: [
                                          Container(
                                            height: 32,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle),
                                            child: Image.network(
                                              streamSnapshot.data!.docs[index]
                                                  ['image'],
                                              color: categoryController.selectedCategoryIndex.value==index
                                                  ? Colors.black
                                                  : Colors.black45,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            streamSnapshot.data!.docs[index]
                                                ['title'],
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: categoryController.selectedCategoryIndex.value==index
                                                  ? Colors.black
                                                  : Colors.black45,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            height: 3,
                                            width: 50,
                                            color: categoryController.selectedCategoryIndex.value==index
                                                ? Colors.black
                                                : Colors.transparent,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
            DisplayTotalprice(),
            Displayplace()
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: MapButton(),
    );
  }
}
