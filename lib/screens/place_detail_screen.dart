import 'package:airbnb_app/components/column_list.dart';
import 'package:airbnb_app/components/myicon_button.dart';
import 'package:airbnb_app/components/price.dart';
import 'package:airbnb_app/components/star_rating.dart';
import 'package:airbnb_app/controller/place_controller.dart';
import 'package:airbnb_app/controller/wishlist_controller.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlaceDetailScreen extends StatelessWidget {
  PlaceDetailScreen({super.key, required this.place});
  final DocumentSnapshot<Object?> place;
  final placeController placecontroller = Get.put(placeController());
  final WishlistController wishlistController = Get.put(WishlistController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: size.height * 0.35,
                  child: AnotherCarousel(
                    images: place['imageUrls']
                        .map((url) => NetworkImage(url))
                        .toList(),
                    showIndicator: false,
                    dotBgColor: Colors.transparent,
                    onImageChange: (p0, p1) {
                      placecontroller.changeIndex(p1);
                    },
                    autoplay: true,
                    boxFit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black45,
                    ),
                    child: Obx(() => Text(
                          "${placecontroller.currentIndex.value + 1}/${place['imageUrls'].length}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
                Positioned(
                  top: 25,
                  left: 15,
                  right: 15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          child: Icon(Icons.arrow_back_ios_new),
                          onTap: () => Get.back()),
                      Row(
                        children: [
                          MyIconButton(icon: Icons.share_outlined),
                          SizedBox(width: 15),
                          MyIconButton(
                            icon: wishlistController.isExist(place)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            iconColor: wishlistController.isExist(place)
                                ? Colors.red
                                : Colors.black,
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place['title'],
                    maxLines: 2,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                        overflow: TextOverflow.ellipsis,
                        height: 1.2),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Room in ${place['address']}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5),
                  Text(
                    place['bedAndBathroom'],
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            if (place['isActive'] == true)
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black26),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          place['rating'].toString(),
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              height: 1.2),
                        ),
                        StarRating(place: place),
                      ],
                    ),
                    Stack(
                      children: [
                        Image.network(
                          "https://wallpapers.com/images/hd/golden-laurel-wreathon-teal-background-k5791qxis5rtcx7w-k5791qxis5rtcx7w.png",
                          height: 50,
                          width: 130,
                          color: Colors.amber,
                        ),
                        Positioned(
                          left: 35,
                          child: Text(
                            "Guest\nfavorite",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          place['review'].toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Reviews",
                          style: TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                              height: 1),
                        )
                      ],
                    )
                  ],
                ),
              )
            else
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.star, size: 20),
                    SizedBox(width: 8),
                    Text(
                      "${place['rating']} .",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          height: 1.3),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "${place['review']} reviews",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(
              height: size.height * .01,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ColumnList(
                    image:
                        "https://static.vecteezy.com/system/resources/previews/018/923/486/original/diamond-symbol-icon-png.png",
                    title: "This is a rare find",
                    subtitle:
                        "${place['vendor']}'s place is usually fully booked.",
                    size: size,
                  ),
                  ColumnList(
                    image: place['vendorProfile'],
                    title: "Stay with ${place['vendor']}",
                    subtitle:
                        "Superhost . ${place['yearOfHostin']} years hosting",
                    size: size,
                  ),
                  ColumnList(
                      size: size,
                      image:
                          "https://cdn-icons-png.flaticon.com/512/6192/6192020.png",
                      title: "Room in a rental unit",
                      subtitle:
                          "Your own room in a home, pluse access\nto shared spaces."),
                  ColumnList(
                      size: size,
                      image:
                          "https://cdn0.iconfinder.com/data/icons/co-working/512/coworking-sharing-17-512.png",
                      title: "Shared common spaces",
                      subtitle:
                          "You'll share parts of the home with the host,"),
                  ColumnList(
                      size: size,
                      image:
                          "https://img.pikbest.com/element_our/20230223/bg/102f90fb4dec6.png!w700wp",
                      title: "Shared bathroom",
                      subtitle: "Your'll share the bathroom with others."),
                  const Divider(),
                  SizedBox(height: size.height * 0.02),
                  const Text(
                    "About this place",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
                  const Divider(),
                  const Text(
                    "Where  you'll be",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    place['address'],
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomSheet: Priceofplaces(place: place),
    );
  }
}
