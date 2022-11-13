import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:module_model/module_model.dart';

import '../cart_redux.dart';

class ItemDetailsView extends StatelessWidget {
  const ItemDetailsView({
    super.key,
    required this.item,
  });

  static const routeName = '/sample_item';

  final SampleItem item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
      ),
      body: StoreConnector<AppState, ViewModel>(
          converter: ViewModel.fromStore,
          builder: (context, vm) {
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/${item.name.toLowerCase()}.png',
                      height: 250,
                      errorBuilder: (context, error, stackTrace) => Container(
                        alignment: Alignment.center,
                        height: 250,
                        child: const Text('NO IMAGE'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        item.name,
                        textScaleFactor: 1.5,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: vm.cart.containsKey(item)
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: (() {
                                    if (vm.cart[item]! > 1) {
                                      vm.onCartDecrement(item);
                                    } else {
                                      vm.onCartRemove(item);
                                    }
                                  }),
                                  icon: const Icon(Icons.remove_circle_outline),
                                ),
                                Text('${vm.cart[item]}'),
                                IconButton(
                                  onPressed: (() {
                                    vm.onCartIncrement(item);
                                  }),
                                  icon: const Icon(Icons.add_circle_outline),
                                ),
                              ],
                            )
                          : null,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        vm.cart.containsKey(item)
                            ? Navigator.of(context).pop()
                            : vm.onCartAdd(item);
                      },
                      child: Text(
                        vm.cart.containsKey(item) ? 'Go back' : 'Add to state',
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
