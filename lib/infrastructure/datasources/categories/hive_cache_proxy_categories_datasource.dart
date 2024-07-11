import 'package:gymnastic_center/domain/datasources/categories/categorie_datasource.dart';
import 'package:gymnastic_center/domain/entities/categories/category.dart';
import 'package:gymnastic_center/infrastructure/cache/core/cache_proxy.dart';
import 'package:gymnastic_center/infrastructure/cache/hive_cache_provider.dart';
import 'package:gymnastic_center/infrastructure/cache/hive_entity_proxies/hive_category_proxy.dart';

class HiveCacheProxyCategoriesDatasource extends CategoryDatasource {
  CategoryDatasource datasource;
  HiveCacheProvider cacheProvider;
  late CacheProxy cacheProxy;

  HiveCacheProxyCategoriesDatasource(this.datasource, this.cacheProvider) {
    cacheProxy = CacheProxy(cacheProvider);
  }

  String _categoriesPaginatedIdentifier({int page = 1, int perPage = 10}) {
    return '${page}_$perPage';
  }

  @override
  Future<List<Category>> getCategoriesPaginated(
      {int page = 1, int perPage = 10}) async {
    var id = _categoriesPaginatedIdentifier(page: page, perPage: perPage);
    return (await cacheProxy.tryRetrieveArray<HiveCategory>(
            truthSource: () async {
              return (await datasource.getCategoriesPaginated(
                      page: page, perPage: perPage))
                  .map((e) => HiveCategory.fromProxiedType(e))
                  .toList();
            },
            collection: 'categories_paginated',
            identifier: id))
        .map((e) => e.toProxiedType())
        .toList();
  }
}
