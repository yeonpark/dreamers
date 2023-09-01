import 'package:flutter/material.dart';

//String uri = 'http://127.0.0.1:8000';
//String uri = 'http://10.68.82.188:8000';
String uri = 'http://10.0.2.2:8000';
//String uri = 'http://147.8.182.111:8000';

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );

  // static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  // static const backgroundColor = Colors.white;
  // static const Color greyBackgroundCOlor = Color(0xffebecee);
  // static var selectedNavBarColor = Color(0xfffca5a5);
  // static const unselectedNavBarColor = Colors.black87;
}

class Pallete {
  static const Color primaryColor = Color(0xfffca5a5);
  static const Color secondaryColor = Color(0xffbef264);
  static const Color accentColor = Color(0xff22d3ee);
  static const Color neutralColor = Color(0xff6b7280);
  static const Color infoColor = Color(0xffe0f2fe);
  static const Color successColor = Color(0xff36D399);
  static const Color warningColor = Color(0xfffbbd23);
  static const Color errorColor = Color(0xfff43f5e);

  static Color titleTextColor = Colors.grey.shade900;
  static Color contentTextColor = Colors.grey.shade600;
  static Color navigationColor = Colors.grey.shade500;
  static Color gradientStartColor = Colors.grey.shade200;
  static Color gradientEndColor = Colors.white;
  static Color dotColor = Colors.grey.shade300;
}

