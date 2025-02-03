import 'package:airbnb_app/authentication/google_authentication.dart';
import 'package:airbnb_app/screens/Appmainpage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AirbnbLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Center(
                    child: Text(
                  "Log in or Sign up",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )),
                Divider(),
                SizedBox(height: 20),
                Text(
                  "Welcome to Airbnb",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                // Country Code and Phone Number Input
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: "Country",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          items: [
                            DropdownMenuItem(
                                value: "+1", child: Text("+1 USA")),
                            DropdownMenuItem(
                                value: "+91", child: Text("+91 India")),
                            DropdownMenuItem(
                                value: "+44", child: Text("+44 UK")),
                          ],
                          onChanged: (value) {},
                        ),
                      ),
                      SizedBox(width: 12),
                      Container(
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: "Phone Number",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                      text:
                          "By continuing, you agree to Airbnb's Terms of Service and acknowledge the ",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.black),
                      children: [
                        TextSpan(
                            text: "Privacy policy",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline))
                      ]),
                ),
                SizedBox(height: 20),
                // Continue Button
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Center(
                    child: Text(
                      "Continue",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * .03,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text("or",
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[600]))),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * .03,
                ),

                // Continue with Facebook
                _buildSocialButton(
                  icon: FontAwesomeIcons.facebook,
                  label: "Continue with Facebook",
                  color: Colors.blue,
                  onPressed: () {},
                  size: size,
                ),
                SizedBox(height: 20),
                // Continue with Google
                _buildSocialButton(
                  icon: FontAwesomeIcons.google,
                  label: "Continue with Google",
                  color: Colors.red,
                  onPressed: () async {
                    await FirebaseAuthServices().SigninwithGoogle();
                    Get.to(Appmainpage());
                  },
                  size: size,
                ),
                SizedBox(height: 20),
                // Continue with Email
                _buildSocialButton(
                  icon: FontAwesomeIcons.envelope,
                  label: "Continue with Email",
                  color: Colors.black,
                  onPressed: () {},
                  size: size,
                ),
                SizedBox(height: 20),
                Center(
                    child: Text(
                  "Need Help?",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(
      {required IconData icon,
      required String label,
      required Color color,
      required VoidCallback onPressed,
      required Size size}) {
    return Container(
      width: size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), border: Border.all()),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
            ),
            SizedBox(
              width: size.width * .15,
            ),
            Text(
              label,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: AirbnbLoginScreen(),
//   ));
// }
