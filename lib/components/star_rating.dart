import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
   StarRating({super.key,required this.place});
  final DocumentSnapshot<Object?> place;
  @override
  Widget Star(bool fill){
    return Icon(Icons.star,size: 18,color: fill?Colors.black:Colors.black26,);
  }
  Widget build(BuildContext context) {
    return Row(
      children:List.generate(5, (index){
        if(index< place['rating'].round()){
          return Star(true);
        }
        else{
          return Star(false);
        }
      })
    );
  }
}
