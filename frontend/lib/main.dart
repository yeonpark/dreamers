import 'package:dreamers/pages/main_page.dart';
import 'package:dreamers/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:dreamers/pages/feed.dart';
import 'package:dreamers/pages/itemlist.dart';
import 'package:dreamers/pages/connect_coinbase_page.dart';

//import '../test_data/success_info.dart';
//import '../test_data/success_info.dart';
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
    ConnectWalletPage()
  ];
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: "/main", routes: {
      "/main": (context) => const MainPage(),
      "/connect-wallet": (context) => const ConnectWalletPage(),
      "/search": (context) => const SearchPage(),
      "/success-story": (context) => const FeedPage(),
    });
  }
}
