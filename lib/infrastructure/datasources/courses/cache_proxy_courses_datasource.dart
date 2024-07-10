import 'package:gymnastic_center/domain/datasources/courses/course_datasource.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/infrastructure/cache/core/cache_provider.dart';
import 'package:gymnastic_center/infrastructure/cache/core/cache_proxy.dart';

class CacheProxyCoursesDatasource extends CoursesDatasource {
  CoursesDatasource datasource;
  CacheProvider cacheProvider;
  late CacheProxy cacheProxy;

  CacheProxyCoursesDatasource(this.datasource, this.cacheProvider) {
    cacheProxy = CacheProxy(cacheProvider);
  }

  String _coursesPaginatedIdentifier(
      {int page = 1,
      int perPage = 10,
      required CourseFilter filter,
      String? trainer,
      String? category}) {
    return '${page}_${perPage}_${filter.name}_${trainer ?? 'notrainer'}_${category ?? 'nocategory'}';
  }

  @override
  Future<Course> getCourseById(String id) async {
    return await cacheProxy.tryRetrieve<Course>(
        truthSource: () => datasource.getCourseById(id),
        collection: 'courses',
        identifier: id);
  }

  @override
  Future<List<Course>> getCoursesPaginated(
      {int page = 1,
      int perPage = 10,
      required CourseFilter filter,
      String? trainer,
      String? category}) async {
    var id = _coursesPaginatedIdentifier(
        page: page,
        perPage: perPage,
        filter: filter,
        trainer: trainer,
        category: category);
    return await cacheProxy.tryRetrieve<List<Course>>(
        truthSource: () => datasource.getCoursesPaginated(
            page: page,
            perPage: perPage,
            filter: filter,
            trainer: trainer,
            category: category),
        collection: 'courses_paginated',
        identifier: id);
  }
}
