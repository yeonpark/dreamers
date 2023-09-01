//import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dreamers/common/widgets/bottom_bar.dart';
import 'package:dreamers/constants/constants.dart';
import 'package:dreamers/features/auth/screens/login_screen.dart';
import 'package:dreamers/features/auth/services/auth_service.dart';
import 'package:dreamers/features/home/services/story_load.dart';
import 'package:dreamers/features/notification/services/get_notification.dart';
import 'package:dreamers/providers/category_provider.dart';
import 'package:dreamers/providers/story_provider.dart';
import 'package:dreamers/providers/notification_provider.dart';
import 'package:dreamers/providers/user_provider.dart';
import 'package:dreamers/providers/wishlist_provider.dart';
import 'package:dreamers/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  // AwesomeNotifications().initialize(
  //   null,
  //   [
  //     NotificationChannel(
  //         channelKey: 'basic_channel',
  //         channelName: 'Basic notifications',
  //         channelDescription: 'Notification Channel for basic tests',
  //     )
  //   ],
  //   debug: true,
  // );
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => StoryProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => WishListProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => CategoryProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => NotificationProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  String? token;

  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('bearer-token');
  }

  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();

    //
    getToken();
    const LoadStory(category: '').loadLikedStory(context);
    const LoadStory(category: 'primary').loadAllStory(context);
    NotificationRetriever().startPolling(context);

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dreamers',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: const ColorScheme.light(
          primary: Pallete.primaryColor
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: token != null ? const BottomBar() : const LoginScreen(),
    );
  }
}
