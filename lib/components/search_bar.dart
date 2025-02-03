import 'package:flutter/material.dart';

class SearchBarandFilter extends StatelessWidget {
  const SearchBarandFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.black54, size: 30),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min, // Ensures compact height
                      children: [
                         Text(
                            "Where to?",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),

                        Text(
                          "Anywhere • Any week • Add guests",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 10),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 1),
              color: Colors.white,
            ),
            child: Icon(Icons.tune, size: 30, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
