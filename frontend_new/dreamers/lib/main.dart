import 'package:dreamers/common/widgets/bottom_bar.dart';
import 'package:dreamers/features/auth/services/auth_service.dart';
import 'package:dreamers/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:dreamers/constants/global_variables.dart';
import 'package:dreamers/features/auth/screens/auth_screen.dart';
import 'package:dreamers/router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    //authService.getUserData(context);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dreamers',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        useMaterial3: true, // can remove this line
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context).user.username.isNotEmpty
          ? const BottomBar()
          : const AuthScreen(),

      // Scaffold(
      //   appBar: AppBar(
      //     title: const Text('Hello.'),
      //   ),
      //   body: Column(
      //     children: [
      //       const Center(
      //         child: Text(
      //           'Flutter Demo Home Page',
      //         ),
      //       ),
      //       Builder(builder: (context) {
      //         return ElevatedButton(
      //           onPressed: () {
      //             Navigator.pushNamed(context, AuthScreen.routeName);
      //           },
      //           child: const Text('Click'),
      //         );
      //       }),
      //     ],
      //   ),
      // ),
      // onGenerateRoute: (settings) => generateRoute(settings),
      // home: Provider.of<UserProvider>(context).user.token.isNotEmpty
      //     ? Provider.of<UserProvider>(context).user.type == 'user'
      //         ? const BottomBar()
      //         : const AdminScreen()
      //     : const AuthScreen(),
    );
  }
}
