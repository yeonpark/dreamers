import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../constants/colors.dart';

class CustomBottomNavbar extends StatelessWidget {
  const CustomBottomNavbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(36)),
          color: navigationColor),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            children: <Widget>[
              customIcon(Ionicons.grid_outline, Colors.white),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Explore",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
          customIcon(Ionicons.search_outline, const Color(0xFFA690DB)),
          customIcon(Ionicons.person_outline, const Color(0xFFA690DB)),
        ],
      ),
    );
  }

  Icon customIcon(IconData icon, Color color) {
    return Icon(
      icon,
      size: 30,
      color: color,
    );
  }
}
