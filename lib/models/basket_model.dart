import 'package:flutter/material.dart';

class BasketModel extends ChangeNotifier {
  Map<int, int> _basket = {2: 4, 3: 6};
  Map<int, int> get basket => _basket;

  void add(int key) {
    if (_basket.containsKey(key)) {
      _basket[key] = _basket[key]! + 1;
    } else {
      _basket[key] = 1;
    }
    notifyListeners();
  }

  void remove(int key) {
    if (_basket.containsKey(key)) {
      _basket[key] = _basket[key]! - 1;
      if (_basket[key] == 0) {
        _basket.remove(key);
      }
    }
    notifyListeners();
  }

  List toList() {
    print(basket.entries.toList());
    return basket.entries.toList();
  }

  void empty() {
    _basket = {};
    notifyListeners();
  }
}
