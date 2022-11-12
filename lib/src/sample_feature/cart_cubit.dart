import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_model/module_model.dart';

class CartCubit extends Cubit<Map<SampleItem, int>> {
  CartCubit() : super({});

  void add(SampleItem item) {
    state.addAll({item: 1});
    Map<SampleItem, int> s = <SampleItem, int>{};
    s.addAll(state);
    emit(s);
  }

  void remove(SampleItem item) {
    state.remove(item);
    Map<SampleItem, int> s = <SampleItem, int>{};
    s.addAll(state);
    emit(s);
  }

  void increment(SampleItem item) {
    var count = state[item];
    state[item] = count!.toInt() + 1;
    Map<SampleItem, int> s = <SampleItem, int>{};
    s.addAll(state);
    emit(s);
  }

  void decrement(SampleItem item) {
    if (state[item]! > 1) {
      state[item] = state[item]! - 1;
    } else {
      state.remove(item);
    }
    Map<SampleItem, int> s = <SampleItem, int>{};
    s.addAll(state);
    emit(s);
  }
}
