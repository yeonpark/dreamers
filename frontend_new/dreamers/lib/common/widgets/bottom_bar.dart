import 'package:dreamers/constants/global_variables.dart';
import 'package:dreamers/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;

  List<Widget> pages = [
    const HomeScreen(),
    const Center(
      child: Text('Feed'),
    ),
    const Center(
      child: Text('Dreamers'),
    ),
    const Center(
      child: Text('Notification'),
    ),
    const Center(
      child: Text('Profile'),
    ),
  ];
  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: const [
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
      ),
    );
  }
}
