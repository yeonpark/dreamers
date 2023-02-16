
import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  final IconData icon;
  final String name;

  Categories({
    super.key,
    required this.icon,
    required this.name,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        width: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            Text(
              name,
              style: TextStyle(letterSpacing: -1, fontSize: 13),
            ),
            SizedBox(width: 40)
          ],
        ),
      ),
    );
  }
}
