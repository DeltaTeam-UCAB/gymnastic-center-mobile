import 'package:gymnastic_center/common/optional.dart';
import 'package:gymnastic_center/infrastructure/cache/core/cache_provider.dart';
import 'package:hive/hive.dart';

class HiveCacheProvider extends CacheProvider {
  @override
  Future<Optional<T>> read<T>(String collection, String identifier) async {
    var box = await Hive.openBox<T>(collection);
    var value = Optional(box.get(identifier));
    await box.close();
    return value;
  }

  @override
  Future<void> write<T>(T data, String collection, String identifier) async {
    var box = await Hive.openBox<T>(collection);
    await box.put(identifier, data);
    await box.close();
  }

  @override
  Future<Optional<List<T>>> readArray<T>(
      String collection, String identifier) async {
    if (!(await Hive.boxExists('${collection}_${identifier}_params'))) {
      return Optional(null);
    }

    var boxArraySize =
        await Hive.openBox<int>('${collection}_${identifier}_params');
    int arraySize = boxArraySize.get('size')!;
    await boxArraySize.close();

    List<T> array = [];

    if (!(await Hive.boxExists('${collection}_$identifier'))) {
      return Optional(null);
    }

    var box = await Hive.openBox<T>('${collection}_$identifier');
    for (int i = 0; i < arraySize; i++) {
      var data = box.get('$i');
      if (data != null) {
        array.add(data);
      }
    }
    await box.close();
    return Optional(array);
  }

  @override
  Future<void> writeArray<T>(
      List<T> data, String collection, String identifier) async {
    var boxArraySize =
        await Hive.openBox<int>('${collection}_${identifier}_params');
    await boxArraySize.put('size', data.length);
    await boxArraySize.close();

    var box = await Hive.openBox<T>('${collection}_$identifier');
    for (int i = 0; i < data.length; i++) {
      await box.put('$i', data[i]);
    }
    await box.close();
  }
}
