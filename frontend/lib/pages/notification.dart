import 'package:flutter/material.dart';
//import '../components/header_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  int noOfNotifications = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "Notifications",
                              style: GoogleFonts.ubuntu(
                                color: titleTextColor,
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                              ),
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
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              primaryColor),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          // side: BorderSide(color: Colors.red),
                                        ),
                                      ),
                                    ),
                                    // ElevatedButton.styleFrom(
                                    //   backgroundColor: primaryColor,
                                    //   shape:
                                    // ),
                                    child: Text(
                                      "Mark All as Read",
                                      style: GoogleFonts.ubuntu(
                                        color: titleTextColor,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                //crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: 'You have ',
                                      style: GoogleFonts.ubuntu(
                                        color: titleTextColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              '$noOfNotifications notifications',
                                          style: GoogleFonts.ubuntu(
                                            color: primaryColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' today',
                                          style: GoogleFonts.ubuntu(
                                            color: titleTextColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Text(
                                  //   'You have $no_notifications notifications today'
                                  // ),
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
                  children: [
                    Flexible(
                      flex: 1,
                      child: NotificationBox(
                        duration: 'Today',
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: NotificationBox(
                        duration: 'This Week',
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: NotificationBox(
                        duration: 'Last Week',
                      ),
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
  final String duration;
  const NotificationBox({
    super.key,
    required this.duration,
  });

  @override
  State<NotificationBox> createState() => _NotificationBoxState();
}

class _NotificationBoxState extends State<NotificationBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.duration,
                  style: GoogleFonts.ubuntu(
                    color: titleTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 4,
            child: Row(
              children: [
                Icon(
                  Icons.circle,
                  size: 10,
                ),
              ],
            ),
          ),
          Flexible(
            flex: 4,
            child: Placeholder(),
          ),
        ],
      ),
    );
  }
}
