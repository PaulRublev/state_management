import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:module_model/module_model.dart';
import 'package:provider/provider.dart';
import 'package:state_management/src/state.dart';

class ItemDetailsView extends StatelessWidget {
  const ItemDetailsView({super.key, required this.item});

  static const routeName = '/sample_item';

  final SampleItem item;

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppState>(context);

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
              Observer(
                name: 'inc/dec',
                builder: ((context) => SizedBox(
                      height: 50,
                      child: state.cart.containsKey(item)
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: (() {
                                    if (state.cart[item]! > 1) {
                                      state.decrement(item);
                                    } else {
                                      state.remove(item);
                                    }
                                  }),
                                  icon: const Icon(Icons.remove_circle_outline),
                                ),
                                Text('${state.cart[item]}'),
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
              Observer(
                name: 'add',
                builder: (context) => ElevatedButton(
                  onPressed: () {
                    state.cart.containsKey(item)
                        ? Navigator.of(context).pop()
                        : state.add(item);
                  },
                  child: Text(
                    state.cart.containsKey(item) ? 'Go back' : 'Add to state',
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
