import 'dart:convert';

import 'package:dreamers/constants/constants.dart';
import 'package:dreamers/features/notification/services/get_notification.dart';
import 'package:dreamers/features/notification/services/read_notification.dart';
import 'package:dreamers/providers/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationScreen extends StatefulWidget {
  static const String routeName = '/notification';
  const NotificationScreen({Key? key}) : super(key: key);

  read() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? notifications = prefs.getString('notifications');
    return jsonDecode(notifications!);
    // String? token = prefs.getString('bearer-token');
  }

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  @override
  void dispose() {
    super.dispose();
  }

  // void markAllRead() {
  //   _NotificationBoxState.noOfNotifications = 0;
  //   _NotificationBoxState.successInfos = _NotificationBoxState.successInfos
  //       .where((successInfos) => successInfos.read = true)
  //       .toList();
  // }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification Page',
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Row(
                          children: const [
                            Icon(
                              Icons.alarm,
                              color: Colors.black,
                              size: 30,
                            ),
                            SizedBox(width: 15),
                            Text(
                              "Notifications",
                              // style: GoogleFonts.ubuntu(
                              //   color: titleTextColor,
                              //   fontSize: 30,
                              //   fontWeight: FontWeight.w900,
                              // ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Column(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(
                                        () {
                                          //markAllRead();
                                          NotificationService()
                                              .showNotification(title: 'Sample title', body: 'It works!');
                                        },
                                      );
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Pallete.primaryColor),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          // side: BorderSide(color: Colors.red),
                                        ),
                                      ),
                                    ),
                                    child: const Text(
                                      "Mark All as Read",
                                      // style: GoogleFonts.ubuntu(
                                      //   color: titleTextColor,
                                      //   fontSize: 22,
                                      //   fontWeight: FontWeight.w400,
                                      // ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 5,
                child: Column(
                  children: const [
                    Flexible(
                      flex: 1,
                      child: NotificationBox(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationBox extends StatefulWidget {
  const NotificationBox({Key? key}) : super(key: key);

  @override
  State<NotificationBox> createState() => _NotificationBoxState();
}

class _NotificationBoxState extends State<NotificationBox> {
  //static const _category = 'last_minute';

  // can't place this value inside the build function as
  // when setstate is called, it reruns the entire build function
  //static List<SuccessInfo> successInfos = successInfo;
  int day = 0;
  int dayindex = 0;
  int thisweek = 0;
  int thisweekindex = 0;
  int lastweek = 0;
  int lastweekindex = 0;
  @override
  Widget build(BuildContext context) {
    //final story = Provider.of<MyProvider>(context).items;
    final notifications = Provider.of<NotificationProvider>(context).items;
    //final notifications = const NotificationScreen().read();
    int noOfNotifications = notifications.length;
    // need to find a way to put this sorting outside of build
    //story.sort((a, b) => b.datetime.compareTo(a.datetime));

    DateTime currentdate = DateTime.now();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Builder(builder: (context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              //crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'You have ',
                    // style: GoogleFonts.ubuntu(
                    //   color: titleTextColor,
                    //   fontSize: 16,
                    //   fontWeight: FontWeight.w400,
                    // ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '$noOfNotifications notifications',
                        // style: GoogleFonts.ubuntu(
                        //   color: primaryColor,
                        //   fontSize: 16,
                        //   fontWeight: FontWeight.w400,
                        // ),
                      ),
                      TextSpan(
                        text: ' today',
                        // style: GoogleFonts.ubuntu(
                        //   color: titleTextColor,
                        //   fontSize: 16,
                        //   fontWeight: FontWeight.w400,
                        // ),
                      ),
                    ],
                  ),
                ),
                // Text(
                //   'You have $no_notifications notifications today'
                // ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  void markAsRead() {
                    // if (noOfNotifications > 0 &&
                    //     story[index].read == false) {
                    //   story[index].read = true;
                    //   --noOfNotifications;
                    // }
                  }

                  // int difference = currentdate
                  //     .difference(DateTime.parse(successInfos[index].datetime))
                  //     .inDays;
                  // if (difference <= 1 && day == 0) {
                  //   day = 1;
                  //   dayindex = index;
                  // } else if (difference > 1 &&
                  //     difference <= 7 &&
                  //     thisweek == 0) {
                  //   thisweek = 1;
                  //   thisweekindex = index;
                  // } else if (difference > 7 && lastweek == 0) {
                  //   lastweek = 1;
                  //   lastweekindex = index;
                  // }
                  return GestureDetector(
                    onTap: () => setState(() {

                      if (notifications[index].read == false) {
                        notifications[index].read = NotificationReader(notification: index+1).readNotification();
                      }

                    }),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index == dayindex) ...[
                          Text(
                            "Today",
                            // style: GoogleFonts.ubuntu(
                            //   fontSize: 12,
                            //   fontWeight: FontWeight.w900,
                            //   color: titleTextColor,
                            // ),
                            textAlign: TextAlign.left,
                          ),
                        ] else if (index == thisweekindex) ...[
                          Text(
                            "This Week",
                            // style: GoogleFonts.ubuntu(
                            //   fontSize: 12,
                            //   fontWeight: FontWeight.w900,
                            //   color: titleTextColor,
                            // ),
                            textAlign: TextAlign.left,
                          ),
                        ] else if (index == lastweekindex) ...[
                          Text(
                            "Last Week",
                            // style: GoogleFonts.ubuntu(
                            //   fontSize: 12,
                            //   fontWeight: FontWeight.w900,
                            //   color: titleTextColor,
                            // ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                        // Text(
                        //   currentdate
                        //               .difference(DateTime.parse(
                        //                   successInfos[index].datetime))
                        //               .inDays <=
                        //           1
                        //       ? "Today"
                        //       : "aa",
                        //   style: GoogleFonts.ubuntu(
                        //     fontSize: 12,
                        //     fontWeight: FontWeight.w900,
                        //     color: titleTextColor,
                        //   ),
                        //   textAlign: TextAlign.left,
                        // ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                            //margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              //color: Colors.orange,
                              border: Border.all(
                                  color: Pallete.neutralColor, // Set border color
                                  width: 3.0), // Set border width
                              borderRadius: BorderRadius.all(Radius.circular(
                                  10.0)), // Set rounded corner radius
                              // Make rounded corner of border
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 10,
                                  color: notifications[index].read
                                      ? Colors.white
                                      : Pallete.primaryColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width -
                                              100),
                                  child: Column(
                                    children: [
                                      Text(
                                        //"This is test data" * 10,
                                        notifications[index].title,
                                        //story[index].full_detail,

                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 4,
                                        // style: GoogleFonts.lato(
                                        //   fontSize: 14,
                                        //   fontWeight: FontWeight.w500,
                                        // ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        //"This is test data" * 10,
                                        notifications[index].description,
                                        //story[index].full_detail,

                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 4,
                                        // style: GoogleFonts.lato(
                                        //   fontSize: 14,
                                        //   fontWeight: FontWeight.w500,
                                        // ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
