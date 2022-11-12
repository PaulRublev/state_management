import 'package:flutter/material.dart';
import 'package:module_business/module_business.dart';
import 'package:module_model/module_model.dart';
import 'package:state_management/src/app.dart';

import 'item_details_view.dart';

class ItemListView extends StatefulWidget {
  ItemListView({super.key});

  static const String path = 'assets/images/';
  static const String logoName = 'flutter_logo.png';
  static const routeName = '/';

  @override
  State<ItemListView> createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {
  late final CartBloc bloc;
  final List<SampleItem> items =
      BlocFactory.instance.mainBloc.itemService.getItemList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Items'),
      ),
      body: StreamBuilder<Map<SampleItem, int>>(
          initialData: const {},
          stream: bloc.state,
          builder: (context, snapshot) {
            return ListView.builder(
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
                        Text(
                          snapshot.data!.containsKey(item)
                              ? snapshot.data![item].toString()
                              : '',
                          textScaleFactor: 0.9,
                        ),
                        const Icon(Icons.shopping_cart_checkout),
                      ],
                    ),
                    leading: CircleAvatar(
                      foregroundImage: AssetImage(
                        '${ItemListView.path}${item.name.toLowerCase()}.png',
                      ),
                      onForegroundImageError: (exception, stackTrace) {},
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        ItemDetailsView.routeName,
                        arguments: {
                          'item': item,
                          'bloc': bloc,
                        },
                      );
                    },
                  ),
                );
              },
            );
          }),
    );
  }

  @override
  void initState() {
    super.initState();
    bloc = CartBloc.instance;
  }

  @override
  void dispose() {
    bloc.dispose;
    super.dispose();
  }
}
