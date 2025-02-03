import 'package:airbnb_app/models/place_model.dart';
import 'package:flutter/material.dart';

class pushplace extends StatelessWidget {
  const pushplace({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Categories')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            uploadPlace();
          },
          child: Text('Upload to Firebase'),
        ),
      ),
    );
  }
}
