import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_model/module_model.dart';

import 'sample_feature/cart_cubit.dart';
import 'sample_feature/item_details_view.dart';
import 'sample_feature/item_list_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit(),
      child: MaterialApp(
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
      ),
    );
  }
}
