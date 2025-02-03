import 'package:airbnb_app/controller/wishlist_controller.dart';
import 'package:airbnb_app/screens/place_detail_screen.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Displayplace extends StatelessWidget {
  Displayplace({super.key});
  final CollectionReference placeCollection =
      FirebaseFirestore.instance.collection("placeCollection");
final WishlistController wishlistController=Get.put(WishlistController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: placeCollection.snapshots(),
        builder: (context, streamSnapshot) {
          if (streamSnapshot.hasData) {
            return Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final place = streamSnapshot.data!.docs[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: GestureDetector(
                        onTap: (){
                          Get.to(()=>PlaceDetailScreen(place: place));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: SizedBox(
                                      height: 360,
                                      width: double.infinity,
                                      child: AnotherCarousel(
                                        images: place['imageUrls']
                                            .map((url) => CachedNetworkImage(
                                                  imageUrl: url,
                                                  fit: BoxFit.cover,
                                                ))
                                            .toList(),
                                        dotSize: 6,
                                        dotColor: Colors.transparent,
                                        indicatorBgPadding: 5,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: 20,
                                    left: 15,
                                    right: 15,
                                    child: Row(
                                      children: [
                                        place['isActive'] == true
                                            ? Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(10),
                                                  child: Text(
                                                    "Guest Favourite",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              )
                                            : SizedBox(
                                                width: size.width * .03,
                                              ),
                                        Spacer(),
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Icon(
                                              Icons.favorite_outline,
                                              size: 35,
                                              color: Colors.white,
                                            ),
                                            Obx(() => InkWell(
                                              onTap: () {
                                                wishlistController.toggleFavorite(place);
                                              },
                                              child: Icon(
                                                Icons.favorite,
                                                size: 31,
                                                color: wishlistController.isExist(place)
                                                    ? Colors.red
                                                    : Colors.black54,
                                              ),
                                            )),
                                          ],
                                        )
                                      ],
                                    )),
                                Positioned(
                                    bottom: 11,
                                    left: 10,
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(15),
                                              bottomRight: Radius.circular(15)),
                                          child: Image.asset(
                                            'assets/book_cover.png',
                                            height: 60,
                                            width: 60,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                            top: 10,
                                            left: 10,
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  place['vendorProfile']),
                                            ))
                                      ],
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: size.height * .01,
                            ),
                            Row(
                              children: [
                                Text(
                                  place['address'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                                Spacer(),
                                Icon(Icons.star),
                                SizedBox(
                                  width: size.width * 0.01,
                                ),
                                Text(
                                  place['rating'].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * .0001,
                            ),
                            Text(
                              "Stay with ${place['vendor']} . ${place['vendorProfession']}",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54),
                            ),
                            SizedBox(
                              height: size.height * .0001,
                            ),
                            Text(
                              place['date'],
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black45),
                            ),
                            SizedBox(
                              height: size.height * .001,
                            ),
                            RichText(
                                text: TextSpan(
                                    text: "\$${place['price']}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                    children: [
                                  TextSpan(
                                    text: "night",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  )
                                ])),
                            SizedBox(height: size.height*.03,)
                          ],
                        ),
                      ),
                    );
                  }),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
