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

class NotificationReader {
  final int notification;

  //final void Function() parentAction;
  const NotificationReader({
    //super.key,
    Key? key,
    //required this.parentAction,
    required this.notification,
  });

  bool readNotification() {
    _fetchData().then((data) {
      // Update the state of the widget in the then() callback
      if (data == true) {
        return false;
      }
    });
    return true;
  }

  Future<bool> _fetchData() async {
    // Simulate an async operation that returns a List<int>
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('bearer-token');

      if (token == null) {
        prefs.setString('bearer-token', '');
      }
      //print(category);
      http.Response res = await http.put(
        Uri.parse('$uri/api/user/read-notification/$notification/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      //print(res.body.runtimeType);
      if (res.body == 'true'){
        Fluttertoast.showToast(msg: 'Notification Read');
        return false;
      }
      // httpErrorHandle(
      //   response: res,
      //   context: context,
      //   onSuccess: () {
      //     return false;
      //   },
      // );
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return true;
  }
}
