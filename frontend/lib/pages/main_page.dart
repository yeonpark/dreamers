import 'package:dreamers/pages/connect_metamask_page.dart';
import 'package:flutter/material.dart';
import 'package:dreamers/pages/feed.dart';
import 'package:dreamers/pages/itemlist.dart';
import 'package:dreamers/pages/connect_coinbase_page.dart';

//import '../test_data/success_info.dart';
//import '../test_data/success_info.dart';
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  final screens = [
    /*
    This list contains the screens to be displayed by different menus.
    When user clicks second menu in bottom navigation bar for example,
    currentIndex will change to 1 and body will display ItemPage which is
    second element of the 'screens' list.
     */
    ItemList(),
    //ItemPage(successInfo: successInfo,),
    FeedPage(),
    Center(
      child: Text(
        "where menu 4 should be",
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
    ConnectMetamaskPage()
  ];
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          /*
      This Scaffold is consisted only with
      body and bottomNavigationBar.
      Body displays the screens based on user's menu selection.
      Default screen (when user first open this app) is first menu page.
      BottomNavigationBar is for menu selection. If user clicks second menu,
      currentIndex changes to 1, so body will display second page (Dart's zero-based indexing.
      */
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