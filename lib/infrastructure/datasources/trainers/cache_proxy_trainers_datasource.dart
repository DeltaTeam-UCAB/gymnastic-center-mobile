import 'package:gymnastic_center/domain/datasources/trainers/trainers_datasource.dart';
import 'package:gymnastic_center/infrastructure/cache/core/cache_provider.dart';
import 'package:gymnastic_center/infrastructure/cache/core/cache_proxy.dart';

class CacheProxyTrainersDatasource extends TrainersDataSource {
  TrainersDataSource datasource;
  CacheProvider cacheProvider;
  late CacheProxy cacheProxy;

  CacheProxyTrainersDatasource(this.datasource, this.cacheProvider) {
    cacheProxy = CacheProxy(cacheProvider);
  }

  String _trainersPaginatedIdentifier(
      {int page = 1, int perPage = 10, bool filterByFollowed = false}) {
    return '${page}_${perPage}_$filterByFollowed';
  }

  @override
  Future<TrainerDetails> getTrainerById(String trainerId) async {
    return await cacheProxy.tryRetrieve(
        truthSource: () => datasource.getTrainerById(trainerId),
        collection: 'trainers',
        identifier: trainerId);
  }

  @override
  Future<List<TrainerDetails>> getTrainersPaginated(
      {int page = 1, int perPage = 10, bool filterByFollowed = false}) async {
    var id = _trainersPaginatedIdentifier(
        page: page, perPage: perPage, filterByFollowed: filterByFollowed);
    return await cacheProxy.tryRetrieve(
        truthSource: () => datasource.getTrainersPaginated(
            page: page, perPage: perPage, filterByFollowed: filterByFollowed),
        collection: 'trainers_paginated',
        identifier: id);
  }

  @override
  Future<bool> toggleFollow(String trainerId) async {
    return await datasource.toggleFollow(trainerId);
  }
}
