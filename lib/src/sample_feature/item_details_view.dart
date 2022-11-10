import 'package:flutter/material.dart';
import 'package:module_model/module_model.dart';
import 'package:provider/provider.dart';

class ItemDetailsView extends StatelessWidget {
  const ItemDetailsView({super.key, required this.item});

  static const routeName = '/sample_item';

  final SampleItem item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
      ),
      body: SingleChildScrollView(
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
              Consumer<Cart>(
                builder: ((context, state, _) => SizedBox(
                      height: 50,
                      child: state.cartItems.containsKey(item)
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: (() {
                                    if (state.cartItems[item]! > 1) {
                                      state.decrement(item);
                                    } else {
                                      state.remove(item);
                                    }
                                  }),
                                  icon: const Icon(Icons.remove_circle_outline),
                                ),
                                Text('${state.cartItems[item]}'),
                                IconButton(
                                  onPressed: (() {
                                    state.increment(item);
                                  }),
                                  icon: const Icon(Icons.add_circle_outline),
                                ),
                              ],
                            )
                          : null,
                    )),
              ),
              Consumer<Cart>(
                builder: (context, state, _) => ElevatedButton(
                  onPressed: () {
                    state.cartItems.containsKey(item)
                        ? Navigator.of(context).pop()
                        : state.add(item);
                  },
                  child: Text(
                    state.cartItems.containsKey(item)
                        ? 'Go back'
                        : 'Add to state',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
