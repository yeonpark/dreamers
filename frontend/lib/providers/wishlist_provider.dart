import 'package:dreamers/models/story.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class WishListProvider with ChangeNotifier {
  List<String> _items = [];

  List<String> get items => _items;

  void setjsonList(List<String> value) {
    _items = value;
    notifyListeners();
  }
}