import 'package:flutter/material.dart';

String uri = 'http://127.0.0.1:8000'; //'http://10.68.82.188:8000';

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );
  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static const selectedNavBarColor = Color(0xfffca5a5);
  static const unselectedNavBarColor = Color(0xff6b7280);

  static const List<String> carouselImages = [
    'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img2021/Vday/bwl/English.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img22/Wireless/AdvantagePrime/BAU/14thJan/D37196025_IN_WL_AdvantageJustforPrime_Jan_Mob_ingress-banner_1242x450.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/Symbol/2020/00NEW/1242_450Banners/PL31_copy._CB432483346_.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/img21/shoes/September/SSW/pc-header._CB641971330_.jpg',
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Last Minute',
      'image': 'Icons.timer_sharp',
    },
    {
      'title': 'Primary/Secondary',
      'image': 'Icons.child_care',
    },
    {
      'title': 'Teritary',
      'image': 'Icons.school_outlined',
    },
    {
      'title': 'Wish List',
      'image': 'Icons.shopping_cart_outlined',
    },
  ];

  static const List<IconData> categoryIcons = [
    Icons.timer_sharp,
    Icons.child_care,
    Icons.school_outlined,
    Icons.shopping_cart_outlined
  ];
}

// Color primaryColor = const Color(0xfffca5a5);
// Color secondaryColor = const Color(0xffbef264);
// Color accentColor = const Color(0xff22d3ee);
// Color neutralColor = const Color(0xff6b7280);
// Color infoColor = const Color(0xffe0f2fe);
// Color successColor = const Color(0xff36D399);
// Color warningColor = const Color(0xfffbbd23);
// Color errorColor = const Color(0xfff43f5e);

// Color titleTextColor = Colors.grey.shade900;
// Color contentTextColor = Colors.grey.shade600;
// Color navigationColor = Colors.grey.shade500;
// Color gradientStartColor = Colors.grey.shade200;
// Color gradientEndColor = Colors.white;
// Color dotColor = Colors.grey.shade300;
