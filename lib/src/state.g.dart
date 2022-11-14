// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppState on _AppState, Store {
  late final _$cartAtom = Atom(name: '_AppState.cart', context: context);

  @override
  ObservableMap<SampleItem, int> get cart {
    _$cartAtom.reportRead();
    return super.cart;
  }

  @override
  set cart(ObservableMap<SampleItem, int> value) {
    _$cartAtom.reportWrite(value, super.cart, () {
      super.cart = value;
    });
  }

  late final _$_AppStateActionController =
      ActionController(name: '_AppState', context: context);

  @override
  void increment(SampleItem item) {
    final _$actionInfo =
        _$_AppStateActionController.startAction(name: '_AppState.increment');
    try {
      return super.increment(item);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decrement(SampleItem item) {
    final _$actionInfo =
        _$_AppStateActionController.startAction(name: '_AppState.decrement');
    try {
      return super.decrement(item);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void add(SampleItem item) {
    final _$actionInfo =
        _$_AppStateActionController.startAction(name: '_AppState.add');
    try {
      return super.add(item);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void remove(SampleItem item) {
    final _$actionInfo =
        _$_AppStateActionController.startAction(name: '_AppState.remove');
    try {
      return super.remove(item);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cart: ${cart}
    ''';
  }
}
