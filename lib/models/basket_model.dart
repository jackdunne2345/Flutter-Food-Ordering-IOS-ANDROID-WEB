import 'package:flutter/material.dart';

class BasketModel extends ChangeNotifier {
  Map<int, int> _basket = {1: 1};
  Map<int, int> get basket => _basket;
  bool _checkOut = false;
  bool get checkOut => _checkOut;
  bool _showBasket = false;
  bool get showBasket => _showBasket;

  void toggleBasket() {
    _showBasket = !_showBasket;
    notifyListeners();
  }

  void setBasket(bool value) {
    _showBasket = value;
    notifyListeners();
  }

  void setCheckOut() {
    _checkOut = !_checkOut;
    notifyListeners();
  }

  void add(int key) {
    if (_basket.containsKey(key)) {
      _basket[key] = _basket[key]! + 1;
    } else {
      _basket[key] = 1;
    }
    notifyListeners();
  }

  void addQuantity(int key, int quant) {
    _basket[key] = quant;

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

  void removeAll(int key) {
    if (_basket.containsKey(key)) {
      _basket.remove(key);
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
