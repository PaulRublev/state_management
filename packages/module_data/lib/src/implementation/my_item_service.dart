import 'package:module_data/module_data.dart';
import 'package:module_model/module_model.dart';

class MyItemService implements ItemService {
  @override
  List<SampleItem> getItemList() {
    return const [
      SampleItem(1, 'Cake'),
      SampleItem(2, 'Chicken'),
      SampleItem(3, 'Donut'),
      SampleItem(4, 'Pizza'),
      SampleItem(5, 'Spaghetti'),
    ];
  }
}
