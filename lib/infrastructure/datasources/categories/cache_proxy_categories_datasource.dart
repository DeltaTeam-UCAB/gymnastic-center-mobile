import 'package:gymnastic_center/domain/datasources/categories/categorie_datasource.dart';
import 'package:gymnastic_center/domain/entities/categories/category.dart';
import 'package:gymnastic_center/infrastructure/cache/core/cache_provider.dart';
import 'package:gymnastic_center/infrastructure/cache/core/cache_proxy.dart';

class CacheProxyCategoriesDatasource extends CategoryDatasource {
  CategoryDatasource datasource;
  CacheProvider cacheProvider;
  late CacheProxy cacheProxy;

  CacheProxyCategoriesDatasource(this.datasource, this.cacheProvider) {
    cacheProxy = CacheProxy(cacheProvider);
  }

  String _categoriesPaginatedIdentifier({int page = 1, int perPage = 10}) {
    return '${page}_$perPage';
  }

  @override
  Future<List<Category>> getCategoriesPaginated(
      {int page = 1, int perPage = 10}) async {
    var id = _categoriesPaginatedIdentifier(page: page, perPage: perPage);
    return await cacheProxy.tryRetrieve(
        truthSource: () =>
            datasource.getCategoriesPaginated(page: page, perPage: perPage),
        collection: 'categories_paginated',
        identifier: id);
  }
}
