import 'package:airbnb_app/models/category_model.dart';
import 'package:flutter/material.dart';

class Uploaddata extends StatelessWidget {
  const Uploaddata({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Categories')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            uploadCollection();
          },
          child: Text('Upload to Firebase'),
        ),
      ),
    );
  }
}
