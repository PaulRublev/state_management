import 'package:flutter/material.dart';

import '../item/sample_item.dart';

class Cart with ChangeNotifier {
  final Map<SampleItem, int> cartItems = {};

  void add(SampleItem item) {
    cartItems.addAll({item: 1});
    notifyListeners();
  }

  void remove(SampleItem item) {
    cartItems.remove(item);
    notifyListeners();
  }

  void increment(SampleItem item) {
    cartItems[item] = cartItems[item]! + 1;
    notifyListeners();
  }

  void decrement(SampleItem item) {
    if (cartItems[item]! > 1) {
      cartItems[item] = cartItems[item]! - 1;
    } else {
      cartItems.remove(item);
    }
    notifyListeners();
  }
}
