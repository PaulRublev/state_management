import 'package:flutter/foundation.dart';
import 'package:module_model/module_model.dart';
import 'package:redux/redux.dart';

class CartAddAction {
  final SampleItem item;

  CartAddAction(this.item);
}

class CartRemoveAction {
  final SampleItem item;

  CartRemoveAction(this.item);
}

class CartIncrementAction {
  final SampleItem item;

  CartIncrementAction(this.item);
}

class CartDecrementAction {
  final SampleItem item;

  CartDecrementAction(this.item);
}

@immutable
class AppState {
  final Map<SampleItem, int> cart;

  const AppState({
    this.cart = const {},
  });

  factory AppState.initial() => const AppState();

  AppState copyWith({
    Map<SampleItem, int>? cart,
  }) {
    return AppState(
      cart: cart ?? this.cart,
    );
  }

  @override
  operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          mapEquals(cart, other.cart);

  @override
  int get hashCode => cart.hashCode;
}

final cartAddReducer = combineReducers<Map<SampleItem, int>>({
  TypedReducer<Map<SampleItem, int>, CartAddAction>(_cartAdd),
});

final cartRemoveReducer = combineReducers<Map<SampleItem, int>>({
  TypedReducer<Map<SampleItem, int>, CartRemoveAction>(_cartRemove),
});

final cartIncrementReducer = combineReducers<Map<SampleItem, int>>({
  TypedReducer<Map<SampleItem, int>, CartIncrementAction>(_cartIncrement),
});

final cartDecrementReducer = combineReducers<Map<SampleItem, int>>({
  TypedReducer<Map<SampleItem, int>, CartDecrementAction>(_cartDecrement),
});

Map<SampleItem, int> _cartAdd(Map<SampleItem, int> cart, CartAddAction action) {
  Map<SampleItem, int>? temp = {};
  temp.addAll(cart);
  temp.addAll({action.item: 1});
  return temp;
}

Map<SampleItem, int> _cartRemove(
    Map<SampleItem, int> cart, CartRemoveAction action) {
  Map<SampleItem, int>? temp = {};
  temp.addAll(cart);
  temp.remove(action.item);
  return temp;
}

Map<SampleItem, int> _cartIncrement(
    Map<SampleItem, int> cart, CartIncrementAction action) {
  Map<SampleItem, int>? temp = {};
  temp.addAll(cart);
  temp[action.item] = temp[action.item]! + 1;
  return temp;
}

Map<SampleItem, int> _cartDecrement(
    Map<SampleItem, int> cart, CartDecrementAction action) {
  Map<SampleItem, int>? temp = {};
  temp.addAll(cart);
  temp[action.item] = temp[action.item]! - 1;
  return temp;
}

AppState appReducer(AppState state, dynamic action) {
  switch (action.runtimeType) {
    case CartRemoveAction:
      return state.copyWith(
        cart: cartRemoveReducer(state.cart, action),
      );
    case CartAddAction:
      return state.copyWith(
        cart: cartAddReducer(state.cart, action),
      );
    case CartIncrementAction:
      return state.copyWith(
        cart: cartIncrementReducer(state.cart, action),
      );
    case CartDecrementAction:
      return state.copyWith(
        cart: cartDecrementReducer(state.cart, action),
      );
  }
  return state;
}

class ViewModel {
  final Map<SampleItem, int> cart;
  final Function onCartAdd;
  final Function onCartRemove;
  final Function onCartIncrement;
  final Function onCartDecrement;

  ViewModel(this.cart, this.onCartAdd, this.onCartRemove, this.onCartIncrement,
      this.onCartDecrement);

  static ViewModel fromStore(Store<AppState> store) => ViewModel(
        store.state.cart,
        (SampleItem item) => store.dispatch(CartAddAction(item)),
        (SampleItem item) => store.dispatch(CartRemoveAction(item)),
        (SampleItem item) => store.dispatch(CartIncrementAction(item)),
        (SampleItem item) => store.dispatch(CartDecrementAction(item)),
      );
}
