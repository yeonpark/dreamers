import 'package:flutter/material.dart';
import 'package:mock_airbnb/secondpage.dart';
import 'package:mock_airbnb/firstpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;
  final screens = [
    FirstPage(),
    SecondPage(),
    Center(
      child: Text(
        "where dreamers page should be",
        style: TextStyle(
          fontSize: 40,
        ),
      ),
    ),
    Center(
      child: Text(
        "where menu 3 page should be",
        style: TextStyle(
          fontSize: 40,
        ),
      ),
    ),
    Center(
      child: Text(
        "where menu 4 should be",
        style: TextStyle(
          fontSize: 40,
        ),
      ),
    ),
  ];
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: screens[currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) => setState(() => currentIndex = index),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Color(0xffff295d),
            unselectedItemColor: Colors.black.withOpacity(0.5),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Menu 1',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border_outlined),
                label: 'Menu 2',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.logo_dev),
                label: 'Dreamers',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.textsms_outlined),
                label: 'Menu 3',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.portrait),
                label: 'Menu 4',
              ),
            ],
          )),
    );
  }
}
