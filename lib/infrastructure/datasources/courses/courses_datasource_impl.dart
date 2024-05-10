import 'package:dio/dio.dart';
import 'package:gymnastic_center/application/key_value_storage/key_value_storage.dart';
import 'package:gymnastic_center/domain/datasources/courses/course_datasource.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/infrastructure/core/constants/environment.dart';
import 'package:gymnastic_center/infrastructure/mappers/course_mapper.dart';
import 'package:gymnastic_center/infrastructure/models/courses/course_response.dart';

class CoursesDatasourceImpl extends CourseDatasource {
  final KeyValueStorageService keyValueStorage;
  final dio = Dio(BaseOptions(baseUrl: Environment.backendApi));
  CoursesDatasourceImpl(KeyValueStorageService keyValueStorageI)
      : keyValueStorage = keyValueStorageI;

  @override
  Future<List<Course>> getCoursesPaginated(
      {int limit = 5, int offset = 0}) async {
    final response = await dio.get(
        '/course/paginated?limit=$limit&offset=$offset',
        options: Options(headers: {
          'auth': await keyValueStorage.getValue<String>('token')
        }));
    final List<Course> courses = [];

    for (final course in response.data ?? []) {
      final courseResponse = CourseResponse.fromJson(course);
      courses.add(CourseMapper.courseToEntity(courseResponse));
    }

    return courses;
  }

  @override
  Future<Course> getCourseById(String id) async {
    final response = await dio.get('/course/information/$id',
        options: Options(headers: {
          'auth': await keyValueStorage.getValue<String>('token')
        }));
    final courseResponse = CourseResponse.fromJson(response.data);
    return CourseMapper.courseToEntity(courseResponse);
  }
}
