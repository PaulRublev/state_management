import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../item/sample_item.dart';

final cartProvider =
    StateNotifierProvider<Cart, Map<SampleItem, int>>((ref) => Cart());

class Cart extends StateNotifier<Map<SampleItem, int>> {
  Cart() : super({});

  void add(SampleItem item) {
    final value = Map<SampleItem, int>.from(state);
    value[item] = 1;
    state = value;
  }

  void remove(SampleItem item) {
    final value = Map<SampleItem, int>.from(state);
    value.remove(item);
    state = value;
  }

  void increment(SampleItem item) {
    final value = Map<SampleItem, int>.from(state);
    if (value.containsKey(item)) {
      value[item] = value[item]! + 1;
    } else {
      value[item] = 1;
    }
    state = value;
  }

  void decrement(SampleItem item) {
    final value = Map<SampleItem, int>.from(state);
    if (value.containsKey(item)) {
      final count = value[item]!;
      if (count < 1) {
        value.remove(item);
      } else {
        value[item] = count - 1;
      }
    }
    state  =  value;
  }
}
