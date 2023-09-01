import 'package:dreamers/constants/error_handling.dart';
import 'package:dreamers/constants/global_variables.dart';
import 'package:dreamers/models/notification.dart' as notif;
import 'package:dreamers/providers/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationRetriever {
  Timer? _timer;
  static int _notificationCount = 0;

  void stopPolling() {
    _timer?.cancel();
    _timer = null;
  }

  void startPolling(
      BuildContext context,
      )
  {
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('bearer-token');

      if (token == null) {
        prefs.setString('bearer-token', '');
      }

      http.Response res = await http.get(
        Uri.parse('$uri/api/user/get-notifications/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );

      List<dynamic> jsonList = jsonDecode(res.body); // as List<dynamic>;
      List<dynamic> reversedJsonList = jsonList.reversed.toList();
      List<notif.Notification> itemList =
        reversedJsonList.map((json) => notif.Notification.fromJson(json)).toList();

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          if (_notificationCount == 0) {
            _notificationCount = itemList.length;
          } else if (_notificationCount < itemList.length) {
            NotificationService()
                .showNotification(title: 'New Notification', body: 'Liked');
            _notificationCount = itemList.length;
            //Fluttertoast.showToast(msg: "New Notification");
          }
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('notifications', jsonEncode(itemList));
          Provider.of<NotificationProvider>(context, listen: false).setjsonList(itemList);
          //print("test2");
        },
      );
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    });
  }
}

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings('flutter_logo');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }
}