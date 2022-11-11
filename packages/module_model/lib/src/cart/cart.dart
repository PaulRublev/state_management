import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../item/sample_item.dart';

final cartProvider =
    StateNotifierProvider<Cart, Map<SampleItem, int>>((ref) => Cart());

class Cart extends StateNotifier<Map<SampleItem, int>> {
  Cart() : super({});

  void add(SampleItem item) {
    state.addAll({item: 1});
  }

  void remove(SampleItem item) {
    state.remove(item);
  }

  void increment(SampleItem item) {
    state[item] = state[item]! + 1;
  }

  void decrement(SampleItem item) {
    if (state[item]! > 1) {
      state[item] = state[item]! - 1;
    } else {
      state.remove(item);
    }
  }
}
