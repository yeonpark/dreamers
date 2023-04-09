import 'package:dreamers/pages/main_page.dart';
import 'package:dreamers/pages/notification.dart';
import 'package:dreamers/pages/profile_page.dart';
import 'package:dreamers/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:dreamers/pages/feed.dart';
import 'pages/connect_coinbase_page.dart';
import 'pages/connect_metamask_page.dart';
import 'pages/login.dart';

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
    return MaterialApp(initialRoute: "/", routes: {
      // 원래 있던 코드 pages/main_page.dart로 갔습니다.
      "/": (context) => const MainPage(),
      "/connect-coinbase": (context) => const ConnectCoinbasePage(),
      "/connect-metamask": (context) => const ConnectMetamaskPage(),
      "/search": (context) => const SearchPage(),
      "/success-story": (context) => const FeedPage(),
      "/notification": (context) => const NotificationPage(),
      "/profile": (context) => const ProfilePage(),
      "/login": (context) => Login(),
    });
  }
}
