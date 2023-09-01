import 'package:dreamers/models/notification.dart';
import 'package:dreamers/models/story.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NotificationProvider with ChangeNotifier {
  List<Notification> _notifications = [];

  List<Notification> get items => _notifications;

  void setjsonList(List<Notification> value) {
    _notifications = value;
    notifyListeners();
  }
}