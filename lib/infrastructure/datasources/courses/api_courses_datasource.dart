import 'package:dio/dio.dart';
import 'package:gymnastic_center/application/key_value_storage/key_value_storage.dart';
import 'package:gymnastic_center/domain/datasources/courses/course_datasource.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/infrastructure/core/constants/environment.dart';
import 'package:gymnastic_center/infrastructure/mappers/course_mapper.dart';
import 'package:gymnastic_center/infrastructure/models/courses/course_response.dart';

class ApiCoursesDatasource extends CoursesDatasource {
  final KeyValueStorageService keyValueStorage;
  final dio = Dio(BaseOptions(baseUrl: Environment.backendApi));

  ApiCoursesDatasource(this.keyValueStorage){
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        options.headers['auth'] = await keyValueStorage.getValue<String>('token');
        return handler.next(options);
      }
    ));
  }

  @override
  Future<List<Course>> getCoursesPaginated(
      {int page = 1, int perPage = 10}) async {

    final response = await dio.get('/course/many?page=$page&perPage=$perPage');
    final List<Course> courses = [];

    for (final course in response.data ?? []) {
      final courseResponse = CourseResponse.fromJson(course);
      courses.add(CourseMapper.courseToEntity(courseResponse));
    }

    return courses;
  }

  @override
  Future<Course> getCourseById(String id) async {
    final response = await dio.get('/course/one/$id');
    final courseResponse = CourseResponse.fromJson(response.data);
    return CourseMapper.courseToEntity(courseResponse);
  }
}
