import 'package:flutter/material.dart';
import 'package:module_model/module_model.dart';
import 'package:state_management/src/app.dart';

class ItemDetailsView extends StatelessWidget {
  const ItemDetailsView({
    super.key,
    required this.item,
    required this.bloc,
  });

  static const routeName = '/sample_item';

  final SampleItem item;
  final CartBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
      ),
      body: StreamBuilder<Map<SampleItem, int>>(
          initialData: CartBloc.cart,
          stream: bloc.state,
          builder: (context, snapshot) {
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
                      child: snapshot.data!.containsKey(item)
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: (() {
                                    if (snapshot.data![item]! > 1) {
                                      bloc.action
                                          .add(CartEvent.decrement.act(item));
                                    } else {
                                      bloc.action
                                          .add(CartEvent.remove.act(item));
                                    }
                                  }),
                                  icon: const Icon(Icons.remove_circle_outline),
                                ),
                                Text('${snapshot.data![item]}'),
                                IconButton(
                                  onPressed: (() {
                                    bloc.action
                                        .add(CartEvent.increment.act(item));
                                  }),
                                  icon: const Icon(Icons.add_circle_outline),
                                ),
                              ],
                            )
                          : null,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        snapshot.data!.containsKey(item)
                            ? Navigator.of(context).pop()
                            : bloc.action.add(CartEvent.add.act(item));
                      },
                      child: Text(
                        snapshot.data!.containsKey(item)
                            ? 'Go back'
                            : 'Add to state',
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
