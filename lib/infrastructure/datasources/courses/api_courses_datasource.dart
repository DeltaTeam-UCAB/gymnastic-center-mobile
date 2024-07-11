import 'package:dio/dio.dart';
import 'package:gymnastic_center/application/key_value_storage/key_value_storage.dart';
import 'package:gymnastic_center/domain/datasources/courses/course_datasource.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/infrastructure/core/constants/environment.dart';
import 'package:gymnastic_center/infrastructure/mappers/course_mapper.dart';
import 'package:gymnastic_center/infrastructure/models/courses/course_response.dart';

class ApiCoursesDatasource extends CoursesDatasource {
  final KeyValueStorageService keyValueStorage;
  final dio = Dio(BaseOptions(baseUrl: '${Environment.backendApi}/course'));

  ApiCoursesDatasource(this.keyValueStorage) {
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      final token = await keyValueStorage.getValue<String>('token');
      options.headers['Authorization'] = 'Bearer $token';
      return handler.next(options);
    }));
  }

  @override
  Future<List<Course>> getCoursesPaginated(
      {page = 1,
      perPage = 10,
      required CourseFilter filter,
      String? trainer,
      String? category}) async {
    final queryParameters = {
      'page': page,
      'perPage': perPage,
      'filter': filter == CourseFilter.recent ? 'RECENT' : 'POPULAR',
    };

    if (trainer != null) {
      queryParameters['trainer'] = trainer;
    }

    if (category != null) {
      queryParameters['category'] = category;
    }

    final response = await dio.get('/many', queryParameters: queryParameters);
    final List<Course> courses = [];

    for (final course in response.data ?? []) {
      final courseResponse = CourseResponse.fromJson(course);
      courses.add(CourseMapper.courseToEntity(courseResponse));
    }

    return courses;
  }

  @override
  Future<Course> getCourseById(String id) async {
    final response = await dio.get('/one/$id');
    final courseResponse = CourseResponse.fromJson(response.data);
    return CourseMapper.courseToEntity(courseResponse);
  }

  @override
  Future<String> deleteCourse(String courseId) async {
    final response = await dio.delete('/one/$courseId');
    return response.data['id'] ?? '';
  }

  @override
  Future<void> deleteLesson(String courseId, String lessonId) async =>
      await dio.delete('/remove/lesson/$courseId/$lessonId');
}
