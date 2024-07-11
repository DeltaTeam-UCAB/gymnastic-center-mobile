import 'package:gymnastic_center/domain/datasources/courses/course_datasource.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/infrastructure/cache/core/cache_proxy.dart';
import 'package:gymnastic_center/infrastructure/cache/hive_cache_provider.dart';
import 'package:gymnastic_center/infrastructure/cache/hive_entity_proxies/hive_course_proxy.dart';

class HiveCacheProxyCoursesDatasource extends CoursesDatasource {
  CoursesDatasource datasource;
  HiveCacheProvider cacheProvider;
  late CacheProxy cacheProxy;

  HiveCacheProxyCoursesDatasource(this.datasource, this.cacheProvider) {
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
    return (await cacheProxy.tryRetrieve<HiveCourse>(
            truthSource: () async {
              return HiveCourse.fromProxiedType(
                  await datasource.getCourseById(id));
            },
            collection: 'courses',
            identifier: id))
        .toProxiedType();
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
    return (await cacheProxy.tryRetrieveArray<HiveCourse>(
            truthSource: () async {
              return (await datasource.getCoursesPaginated(
                      page: page,
                      perPage: perPage,
                      filter: filter,
                      trainer: trainer,
                      category: category))
                  .map((e) => HiveCourse.fromProxiedType(e))
                  .toList();
            },
            collection: 'courses_paginated',
            identifier: id))
        .map((e) => e.toProxiedType())
        .toList();
  }

  @override
  Future<String> deleteCourse(String courseId) async {
    var result = await datasource.deleteCourse(courseId);
    await cacheProvider.delete('courses', courseId);
    return result;
  }

  @override
  Future<void> deleteLesson(String courseId, String lessonId) async {
    return await datasource.deleteLesson(courseId, lessonId);
  }
}
