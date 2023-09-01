// import 'package:flutter/material.dart';
//
// class MyProvider with ChangeNotifier {
//   late List<dynamic> _jsonList;
//
//   List<dynamic> get jsonList => _jsonList;
//
//   void setjsonList(List<dynamic> value) {
//     _jsonList = value;
//     notifyListeners();
//   }
// }
import 'package:dreamers/models/story.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class StoryProvider with ChangeNotifier {
  List<Story> _items = [];

  List<Story> get items => _items;

  void setjsonList(List<Story> value) {
    _items = value;
    notifyListeners();
  }

  List<UserModel> _profile = [];

  List<UserModel> get profile => _profile;

  void setUserjsonList(List<UserModel> value) {
    _profile = value;
    notifyListeners();
  }
}
