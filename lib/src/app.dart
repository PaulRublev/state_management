import 'dart:async';

import 'package:flutter/material.dart';
import 'package:module_model/module_model.dart';

import 'sample_feature/item_details_view.dart';
import 'sample_feature/item_list_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'app',
      theme: ThemeData.dark(),
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            switch (routeSettings.name) {
              case ItemDetailsView.routeName:
                Map<String, dynamic> args =
                    routeSettings.arguments as Map<String, dynamic>;
                return ItemDetailsView(
                  item: args.containsKey('item')
                      ? args['item'] as SampleItem
                      : const SampleItem(-1, 'errorItem'),
                  bloc: args.containsKey('bloc')
                      ? args['bloc'] as CartBloc
                      : CartBloc.instance,
                );
              case ItemListView.routeName:
              default:
                return ItemListView();
            }
          },
        );
      },
    );
  }
}

enum CartEvent {
  add,
  remove,
  increment,
  decrement;
}

extension CartEventExtension on CartEvent {
  CartEvent act(SampleItem item) {
    switch (this) {
      case CartEvent.add:
        CartBloc.cart.addAll({item: 1});
        return this;
      case CartEvent.remove:
        CartBloc.cart.remove(item);
        return this;
      case CartEvent.increment:
        CartBloc.cart[item] = CartBloc.cart[item]! + 1;
        return this;
      case CartEvent.decrement:
        if (CartBloc.cart[item]! > 1) {
          CartBloc.cart[item] = CartBloc.cart[item]! - 1;
        } else {
          CartBloc.cart.remove(item);
        }
        return this;
    }
  }
}

class CartBloc {
  CartBloc._pr() {
    _eventController.stream.listen(_handleEvent);
  }
  static final CartBloc instance = CartBloc._pr();

  static Map<SampleItem, int> cart = {};

  final _stateController = StreamController<Map<SampleItem, int>>.broadcast();
  final _eventController = StreamController<CartEvent>();

  Stream<Map<SampleItem, int>> get state => _stateController.stream;

  Sink<CartEvent> get action => _eventController.sink;

  void dispose() {
    _stateController.close();
    _eventController.close();
  }

  void _handleEvent(CartEvent action) async {
    switch (action) {
      case CartEvent.add:
      case CartEvent.remove:
      case CartEvent.increment:
      case CartEvent.decrement:
      default:
        _stateController.add(cart);
    }
  }
}
