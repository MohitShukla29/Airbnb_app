import 'package:airbnb_app/controller/wishlist_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Wishlist extends StatelessWidget {
  Wishlist({super.key});
  final WishlistController wishlistController = Get.put(WishlistController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Edit',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Wishlists",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            Obx(() => wishlistController.favoriteIds.isEmpty
                ? Text(
              "No Favorite items",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            )
                : SizedBox(
              height: MediaQuery.of(context).size.height * .68,
              child: StreamBuilder<QuerySnapshot>(
                // Listen to FavoriteCollection for real-time updates
                stream: FirebaseFirestore.instance
                    .collection('FavoriteCollection')
                    .where('isFavorite', isEqualTo: true)
                    .snapshots(),
                builder: (context, favoriteSnapshot) {
                  if (favoriteSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (!favoriteSnapshot.hasData ||
                      favoriteSnapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text("No favorites found"),
                    );
                  }

                  // Get all favorite document IDs
                  List<String> favoriteIds = favoriteSnapshot.data!.docs
                      .map((doc) => doc.id)
                      .toList();

                  // Use another StreamBuilder to fetch place details
                  return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('placeCollection')
                        .where(FieldPath.documentId, whereIn: favoriteIds)
                        .snapshots(),
                    builder: (context, placeSnapshot) {
                      if (placeSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (!placeSnapshot.hasData ||
                          placeSnapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text("Error loading place details"),
                        );
                      }

                      return GridView.builder(
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1,
                        ),
                        padding: EdgeInsets.all(10),
                        itemCount: placeSnapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          var placeData = placeSnapshot.data!.docs[index]
                              .data() as Map<String, dynamic>;

                          return Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      placeData['image'],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                              ),
                              Positioned(
                                bottom: 8,
                                left: 8,
                                right: 8,
                                child: Container(
                                  color: Colors.black.withOpacity(0.6),
                                  padding: const EdgeInsets.all(4),
                                  child: Text(
                                    placeData['title'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            )),
          ],
        ),
      ),
    );
  }
}