import 'package:gymnastic_center/common/optional.dart';
import 'package:gymnastic_center/infrastructure/cache/core/cache_provider.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class CacheProxy {
  CacheProvider cacheProvider;

  CacheProxy(this.cacheProvider);

  Future<T> tryRetrieve<T>(
      {required Future<T> Function() truthSource,
      required String collection,
      required String identifier}) async {
    try {
      if (await InternetConnection().hasInternetAccess) {
        var data = await truthSource();
        await cacheProvider.write(data, collection, identifier);
        return data;
      } else {
        Optional<T> cacheData =
            await cacheProvider.read(collection, identifier);
        if (cacheData.hasValue()) {
          print(cacheData.getValue());
          return cacheData.getValue();
        }
      }
    } on Error catch (e) {
      print(e);
      print(e.stackTrace);
    }
    throw Exception(
        'Could not get data, check your connection or try again later');
  }

  Future<List<T>> tryRetrieveArray<T>(
      {required Future<List<T>> Function() truthSource,
      required String collection,
      required String identifier}) async {
    try {
      if (await InternetConnection().hasInternetAccess) {
        var data = await truthSource();
        await cacheProvider.writeArray<T>(data, collection, identifier);
        return data;
      } else {
        Optional<List<T>> cacheData =
            await cacheProvider.readArray<T>(collection, identifier);
        if (cacheData.hasValue()) {
          print(cacheData.getValue());
          return cacheData.getValue();
        }
      }
    } on Error catch (e) {
      print(e);
      print(e.stackTrace);
    }
    throw Exception(
        'Could not get data, check your connection or try again later');
  }
}
