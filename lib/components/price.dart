import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Priceofplaces extends StatelessWidget {
  const Priceofplaces({super.key,required this.place});
  final DocumentSnapshot<Object?> place;
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.1,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  text: "\$${place['price']} ",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  children: const [
                    TextSpan(
                      text: "night",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                place['date'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              )
            ],
          ),
          SizedBox(
            width: size.width * 0.3,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 35,
              vertical: 15,
            ),
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Text(
              "Reserve",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );;
  }
}
