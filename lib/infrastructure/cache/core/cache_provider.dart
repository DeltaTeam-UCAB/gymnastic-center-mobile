import 'package:gymnastic_center/common/optional.dart';

abstract class CacheProvider {
  Future<void> write<T>(T data, String collection, String identifier);
  Future<Optional<T>> read<T>(String collection, String identifier);
  Future<void> delete<T>(String collection, String identifier);
  Future<void> writeArray<T>(
      List<T> data, String collection, String identifier);
  Future<Optional<List<T>>> readArray<T>(String collection, String identifier);
}
