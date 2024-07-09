import 'package:gymnastic_center/common/optional.dart';
import 'package:gymnastic_center/infrastructure/cache/core/cache_provider.dart';
import 'package:hive/hive.dart';

class HiveCacheProvider extends CacheProvider {
  @override
  Future<Optional<T>> read<T>(String collection, String identifier) async {
    var box = await Hive.openBox<T>(collection);
    var value = Optional(box.get(identifier));
    box.close();
    return value;
  }

  @override
  Future<void> write<T>(T data, String collection, String identifier) async {
    var box = await Hive.openBox<T>(collection);
    await box.put(identifier, data);
    box.close();
  }
}
