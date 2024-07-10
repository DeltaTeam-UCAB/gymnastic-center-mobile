import 'package:gymnastic_center/domain/datasources/trainers/trainers_datasource.dart';
import 'package:gymnastic_center/infrastructure/cache/core/cache_proxy.dart';
import 'package:gymnastic_center/infrastructure/cache/hive_cache_provider.dart';
import 'package:gymnastic_center/infrastructure/cache/hive_entity_proxies/hive_trainer_details_proxy.dart';

class HiveCacheProxyTrainersDatasource extends TrainersDataSource {
  TrainersDataSource datasource;
  HiveCacheProvider cacheProvider;
  late CacheProxy cacheProxy;

  HiveCacheProxyTrainersDatasource(this.datasource, this.cacheProvider) {
    cacheProxy = CacheProxy(cacheProvider);
  }

  String _trainersPaginatedIdentifier(
      {int page = 1, int perPage = 10, bool filterByFollowed = false}) {
    return '${page}_${perPage}_$filterByFollowed';
  }

  @override
  Future<TrainerDetails> getTrainerById(String trainerId) async {
    return (await cacheProxy.tryRetrieve<HiveTrainerDetails>(
            truthSource: () async {
              return HiveTrainerDetails.fromProxiedType(
                  await datasource.getTrainerById(trainerId));
            },
            collection: 'trainers',
            identifier: trainerId))
        .toProxiedType();
  }

  @override
  Future<List<TrainerDetails>> getTrainersPaginated(
      {int page = 1, int perPage = 10, bool filterByFollowed = false}) async {
    var id = _trainersPaginatedIdentifier(
        page: page, perPage: perPage, filterByFollowed: filterByFollowed);
    return (await cacheProxy.tryRetrieve<List<HiveTrainerDetails>>(
            truthSource: () async {
              return (await datasource.getTrainersPaginated(
                      page: page,
                      perPage: perPage,
                      filterByFollowed: filterByFollowed))
                  .map((e) => HiveTrainerDetails.fromProxiedType(e))
                  .toList();
            },
            collection: 'trainers_paginated',
            identifier: id))
        .map((e) => e.toProxiedType())
        .toList();
  }

  @override
  Future<bool> toggleFollow(String trainerId) async {
    return await datasource.toggleFollow(trainerId);
  }
}
