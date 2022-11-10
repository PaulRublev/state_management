import 'package:get_it/get_it.dart';
import 'api/item_service.dart';
import 'implementation/my_item_service.dart';

class ServiceProvider {
  static final _getIt = GetIt.I;

  T get<T extends Object>() => _getIt.get<T>();

  static final instance = ServiceProvider();

  void initialize() {
    _getIt.registerFactory<ItemService>(
      () => MyItemService(),
    );
  }
}
