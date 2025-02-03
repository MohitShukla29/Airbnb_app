import 'package:airbnb_app/controller/mainpage_controller.dart';
import 'package:airbnb_app/screens/Message_screen.dart';
import 'package:airbnb_app/screens/explore_screen.dart';
import 'package:airbnb_app/screens/profile_screen.dart';
import 'package:airbnb_app/screens/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Appmainpage extends StatelessWidget {
   Appmainpage({super.key});
   AppController appController=Get.put(AppController());
   final List<Widget>pages=[
    ExploreScreen(),
    Wishlist(),
    const Scaffold(),
    MessageScreen(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(()=>pages[appController.selectedIndex.value]),
      bottomNavigationBar: Obx(()=>
         BottomNavigationBar(
            backgroundColor: Colors.white,
            selectedItemColor: Colors.pinkAccent,
            iconSize: 32,
            unselectedItemColor: Colors.black,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            currentIndex: appController.selectedIndex.value,
            onTap:(index){
              print("Tapped Index: $index");
              appController.changeIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search,
                    size: 30,
                  ),
                  label: "Explore",),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border,size: 30,),
                  label: "Wishlist"),
              BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.suitcaseRolling,size: 30,),
                  label: "Trips",),
              BottomNavigationBarItem(
                  icon:   Icon(FontAwesomeIcons.envelope,size: 30,),
                  label: "Message"),
              BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.user,size: 30,),
                  label: "Profile"),
            ]),
      ),
    );
  }
}
