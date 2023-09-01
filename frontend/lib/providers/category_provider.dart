import 'package:flutter/foundation.dart';

class CategoryProvider extends ChangeNotifier {
  String _category = 'primary';

  String get category => _category;

  void setCategory(String category) {
    _category = category;
    notifyListeners();
  }
}