import 'package:dreamers/pages/connect_metamask_page.dart';
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
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: "/main", routes: {
      // 원래 있던 코드 pages/main_page.dart로 갔습니다.
      "/main": (context) => const MainPage(),
      "/connect-coinbase": (context) => const ConnectWalletPage(),
      "/connect-metamask": (context) => const ConnectMetaMaskPage(),
      "/search": (context) => const SearchPage(),
      "/success-story": (context) => const FeedPage(),
    });
  }
}
