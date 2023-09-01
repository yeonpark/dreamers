// ignore_for_file: prefer_const_constructors

import 'package:dreamers/common/widgets/bottom_bar.dart';
import 'package:dreamers/features/home/screens/item_list_screen.dart';
import 'package:flutter/material.dart';

import 'package:dreamers/common/widgets/home_button.dart';

class ThankYouPage extends StatefulWidget {
  static const String routeName = '/post-payment';
  const ThankYouPage({Key? key}) : super(key: key);

  @override
  State<ThankYouPage> createState() => _ThankYouPageState();
}

Color themeColor = const Color(0xFF43D19E);

class _ThankYouPageState extends State<ThankYouPage> {
  double screenWidth = 600;
  double screenHeight = 400;
  Color textColor = const Color(0xFF32567A);

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 170,
              padding: EdgeInsets.all(35),
              decoration: BoxDecoration(
                color: themeColor,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                "assets/card.png",
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: screenHeight * 0.1),
            Text(
              "Thank You!",
              style: TextStyle(
                color: themeColor,
                fontWeight: FontWeight.w600,
                fontSize: 36,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              "Payment done Successfully",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                fontSize: 17,
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            Text(
              "Click below to return to story page",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            SizedBox(height: screenHeight * 0.06),
            GestureDetector(
              onTap: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      Text("Story Page", style: TextStyle(color: Colors.white)),
                ),
                color: Colors.amber,
              ),
            )
          ],
        ),
      ),
    );
  }
}
