import 'package:badges/badges.dart';
import 'package:dreamers/constants/global_variables.dart';
import 'package:dreamers/features/account/screens/profile_screen.dart';
import 'package:dreamers/features/home/screens/item_list_screen.dart';
import 'package:dreamers/features/story/screens/post_story_screen.dart';
import 'package:dreamers/features/home/services/story_load.dart';
import 'package:dreamers/features/notification/screens/notification_screen.dart';
import 'package:dreamers/features/feeds/screens/feed_screen.dart';
import 'package:dreamers/features/account/services/profile_service.dart';
import 'package:dreamers/providers/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:dreamers/features/feeds/screens/feed_screen.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  void navigateToPostStory() {
    Navigator.pushNamed(context, PostStoryScreen.routeName);
  }

  int currentTab = 0;

  final List<Widget> screens = [
    const ItemList(),
    const PostStoryScreen(),
    const NotificationScreen(),
    const AccountScreen(),
    const FeedScreen(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const ItemList();

  final ProfileServices profileServices = ProfileServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(bucket: bucket, child: currentScreen),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add_circle_outline_outlined,
        ),
        onPressed: () {
          showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Post Story',
                          style: GoogleFonts.ubuntu(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 25),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xfffca5a5))),
                          child: Text(
                            'Tell us your dream!',
                            style: GoogleFonts.ubuntu(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                          onPressed: navigateToPostStory,
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home_outlined),
              color: currentTab == 0 ? Colors.red : Colors.black,
              onPressed: () {
                setState(
                  () {
                    currentScreen = ItemList();
                    currentTab = 0;
                  },
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.feed_outlined),
              color: currentTab == 1 ? Colors.red : Colors.black,
              onPressed: () {
                setState(
                  () {
                    currentScreen = FeedScreen();
                    currentTab = 1;
                  },
                );
              },
            ),
            SizedBox(
              width: 40,
            ),
            IconButton(
              icon: Icon(Icons.notifications_outlined),
              color: currentTab == 2 ? Colors.red : Colors.black,
              onPressed: () {
                setState(
                  () {
                    currentScreen = NotificationScreen();
                    currentTab = 2;
                  },
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.person_outline_outlined),
              color: currentTab == 3 ? Colors.red : Colors.black,
              onPressed: () {
                setState(
                  () {
                    currentScreen = AccountScreen();
                    currentTab = 3;
                    profileServices.loadUserProfile(context: context);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
