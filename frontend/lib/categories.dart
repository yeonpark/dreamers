import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  final IconData icon;
  final String name;

  Categories({
    super.key,
    required this.icon,
    required this.name,
  });

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: GestureDetector(
        onTap: () => print('category pressed'),
        child: Container(
          width: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    widget.icon,
                    size: 25,
                    color: Colors.black.withOpacity(0.7),
                  )),
              SizedBox(height: 3),
              Text(
                widget.name,
                style: TextStyle(
                    letterSpacing: -1, fontSize: 10, color: Colors.grey),
              ),
              SizedBox(width: 40)
            ],
          ),
        ),
      ),
    );
  }
}
