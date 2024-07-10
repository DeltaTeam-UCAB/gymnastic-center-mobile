import 'package:gymnastic_center/domain/datasources/trainers/trainers_datasource.dart';
import 'package:gymnastic_center/infrastructure/cache/core/cache_provider.dart';
import 'package:gymnastic_center/infrastructure/cache/core/cache_retriever.dart';

class CacheProxyTrainersDatasource extends TrainersDataSource {
  TrainersDataSource datasource;
  CacheProvider cacheProvider;
  late CacheRetriever cacheRetriever;

  CacheProxyTrainersDatasource(this.datasource, this.cacheProvider) {
    cacheRetriever = CacheRetriever(cacheProvider);
  }

  String _trainersPaginatedIdentifier(
      {int page = 1, int perPage = 10, bool filterByFollowed = false}) {
    return '${page}_${perPage}_$filterByFollowed';
  }

  @override
  Future<TrainerDetails> getTrainerById(String trainerId) async {
    return await cacheRetriever.retrieve(
        truthSource: () => datasource.getTrainerById(trainerId),
        collection: 'trainers',
        identifier: trainerId);
  }

  @override
  Future<List<TrainerDetails>> getTrainersPaginated(
      {int page = 1, int perPage = 10, bool filterByFollowed = false}) async {
    var id = _trainersPaginatedIdentifier(
        page: page, perPage: perPage, filterByFollowed: filterByFollowed);
    return await cacheRetriever.retrieve(
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
