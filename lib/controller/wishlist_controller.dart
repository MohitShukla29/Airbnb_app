import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class WishlistController extends GetxController{
  var favoriteIds =<String> [].obs;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
// List<String> get favorites => _favoriteIds;

  void toggleFavorite(DocumentSnapshot place) async {
    String placeId = place.id;
    if (favoriteIds.contains(placeId)) {
      favoriteIds.remove(placeId);
      await _removeFavorite(placeId);
    } else {
      favoriteIds.add(placeId);
      await _addFavorite(placeId);
    }
  }

  bool isExist(DocumentSnapshot place) {
    return favoriteIds.contains(place.id);
  }

  Future<void> _addFavorite(String placeId) async {
    try {
      await firebaseFirestore
          .collection('FavoriteCollection')
          .doc(placeId)
          .set({'isFavorite': true});
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _removeFavorite(String placeId) async {
    try {
      await firebaseFirestore.collection('FavoriteCollection').doc(placeId).update(
          {'isFavorite': false});
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> loadFavorite() async {
    try {
      QuerySnapshot snapshot =
      await firebaseFirestore.collection('FavoriteCollection').where('isFavorite',isEqualTo: 'true').get();
      favoriteIds.assignAll(snapshot.docs.map((doc) => doc.id).toList());
    } catch (e) {
      print(e.toString());
    }
  }

}
