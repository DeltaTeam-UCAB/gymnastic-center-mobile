import 'package:dio/dio.dart';
import 'package:gymnastic_center/application/key_value_storage/key_value_storage.dart';
import 'package:gymnastic_center/domain/datasources/search/search_datasource.dart';
import 'package:gymnastic_center/infrastructure/core/constants/environment.dart';
import 'package:gymnastic_center/infrastructure/mappers/blog_mapper.dart';
import 'package:gymnastic_center/infrastructure/mappers/course_mapper.dart';
import 'package:gymnastic_center/infrastructure/models/blogs/blog_apiblog.dart';
import 'package:gymnastic_center/infrastructure/models/courses/course_response.dart';

class ApiSearchDatasource extends SearchDataSource {
  final KeyValueStorageService keyValueStorage;
  final dio = Dio(BaseOptions(baseUrl: '${Environment.backendApi}/search'));

  ApiSearchDatasource(this.keyValueStorage) {
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      final token = await keyValueStorage.getValue<String>('token');
      options.headers['Authorization'] = 'Bearer $token';
      return handler.next(options);
    }));
  }

  @override
  Future<SearchResponse> search(
      {int page = 1,
      int perPage = 8,
      List<String> tags = const [],
      required String term}) async {
    final response = await dio.get(
      '/all',
      queryParameters: {
        'page': page,
        'perPage': perPage,
        'term': term,
        'tags': tags.map((tag) => '["$tag"]').join(','),
      },
    );

    final courses = (response.data['courses'] as List).map((data) {
      final apiCourseResponse = CourseResponse.fromJson(data);
      return CourseMapper.courseToEntity(apiCourseResponse);
    }).toList();

    final blogs = (response.data['blogs'] as List).map((data) {
      final apiBlogResponse = BlogAPIBlog.fromJson(data);
      return BlogMapper.apiBlogToEntity(apiBlogResponse);
    }).toList();

    return SearchResponse(courses: courses, blogs: blogs);
  }

  @override
  Future<List<String>> loadPopularTags([page = 1, perPage = 10]) async {
    final response = await dio.get('/popular/tags', queryParameters: {
      'page': page,
      'perPage': perPage,
    });
    final tags = List<String>.from(response.data.map((x) => x.toString()));
    return tags;
  }
}
