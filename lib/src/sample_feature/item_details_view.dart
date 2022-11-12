import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_model/module_model.dart';

import 'cart_cubit.dart';

class ItemDetailsView extends StatelessWidget {
  const ItemDetailsView({
    super.key,
    required this.item,
  });

  static const routeName = '/sample_item';

  final SampleItem item;

  @override
  Widget build(BuildContext context) {
    final cartWatchState = context.watch<CartCubit>().state;
    final cartRead = context.read<CartCubit>();

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
              SizedBox(
                height: 50,
                child: cartWatchState.containsKey(item)
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: (() {
                              if (cartRead.state[item]! > 1) {
                                cartRead.decrement(item);
                              } else {
                                cartRead.remove(item);
                              }
                            }),
                            icon: const Icon(Icons.remove_circle_outline),
                          ),
                          Text('${cartWatchState[item]}'),
                          IconButton(
                            onPressed: (() {
                              cartRead.increment(item);
                            }),
                            icon: const Icon(Icons.add_circle_outline),
                          ),
                        ],
                      )
                    : null,
              ),
              ElevatedButton(
                onPressed: () {
                  cartRead.state.containsKey(item)
                      ? Navigator.of(context).pop()
                      : cartRead.add(item);
                },
                child: Text(
                  cartWatchState.containsKey(item) ? 'Go back' : 'Add to state',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
