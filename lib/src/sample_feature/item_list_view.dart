import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:module_business/module_business.dart';
import 'package:module_model/module_model.dart';
import 'package:provider/provider.dart';
import 'package:state_management/src/state.dart';

import 'item_details_view.dart';

class ItemListView extends StatelessWidget {
  ItemListView({super.key});

  static const String path = 'assets/images/';
  static const String logoName = 'flutter_logo.png';
  static const routeName = '/';

  final List<SampleItem> items =
      BlocFactory.instance.mainBloc.itemService.getItemList();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Items'),
      ),
      body: ListView.builder(
        restorationId: 'sampleItemListView',
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              title: Text(item.name),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Observer(
                      name: 'all',
                      builder: (context) {
                        return Text(
                          state.cart.containsKey(item)
                              ? state.cart[item].toString()
                              : '',
                          textScaleFactor: 0.9,
                        );
                      }),
                  const Icon(Icons.shopping_cart_checkout),
                ],
              ),
              leading: CircleAvatar(
                foregroundImage: AssetImage(
                  '$path${item.name.toLowerCase()}.png',
                ),
                onForegroundImageError: (exception, stackTrace) {},
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  ItemDetailsView.routeName,
                  arguments: {'item': item},
                );
              },
            ),
          );
        },
      ),
    );
  }
}
