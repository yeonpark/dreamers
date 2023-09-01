import 'package:dreamers/constants/constants.dart';
import 'package:flutter/material.dart';

class UIConstants {
  static AppBar appBar() {
    return AppBar(
      title: Column(
        children: [
          const SizedBox(height: 15),
          Image.asset(
            "assets/images/logo.png",
            width: 50,
            height: 50,
            ),
        ],
      ),
      centerTitle: true,
      backgroundColor: Pallete.infoColor,
    );
  }
}