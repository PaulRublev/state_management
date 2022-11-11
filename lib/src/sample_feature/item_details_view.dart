import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:module_model/module_model.dart';

class ItemDetailsView extends ConsumerWidget {
  const ItemDetailsView({super.key, required this.item});

  static const routeName = '/sample_item';

  final SampleItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              Consumer(
                builder: ((context, ref, _) => SizedBox(
                      height: 50,
                      child: ref.watch(cartProvider).containsKey(item)
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: (() {
                                    if (ref.watch(cartProvider)[item]! > 1) {
                                      ref
                                          .read(cartProvider.notifier)
                                          .decrement(item);
                                    } else {
                                      ref
                                          .watch(cartProvider.notifier)
                                          .remove(item);
                                    }
                                  }),
                                  icon: const Icon(Icons.remove_circle_outline),
                                ),
                                Text('${ref.watch(cartProvider)[item]}'),
                                IconButton(
                                  onPressed: (() {
                                    ref
                                        .read(cartProvider.notifier)
                                        .increment(item);
                                  }),
                                  icon: const Icon(Icons.add_circle_outline),
                                ),
                              ],
                            )
                          : null,
                    )),
              ),
              Consumer(
                builder: (context, ref, _) => ElevatedButton(
                  onPressed: () {
                    ref.watch(cartProvider).containsKey(item)
                        ? Navigator.of(context).pop()
                        : ref.read(cartProvider.notifier).add(item);
                  },
                  child: Text(
                    ref.watch(cartProvider).containsKey(item)
                        ? 'Go back'
                        : 'Add to ref',
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
