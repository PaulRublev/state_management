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
