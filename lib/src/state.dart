import 'package:mobx/mobx.dart';
import 'package:module_model/module_model.dart';

part 'state.g.dart';

class AppState = _AppState with _$AppState;

abstract class _AppState with Store {
  @observable
  ObservableMap<SampleItem, int> cart = ObservableMap<SampleItem, int>.of({});

  @action
  void increment(SampleItem item) {
    cart[item] = cart[item]! + 1;
  }

  @action
  void decrement(SampleItem item) {
    if (cart[item]! > 1) {
      cart[item] = cart[item]! - 1;
    } else {
      remove(item);
    }
  }

  @action
  void add(SampleItem item) {
    cart.addAll({item: 1});
  }

  @action
  void remove(SampleItem item) {
    cart.remove(item);
  }
}
