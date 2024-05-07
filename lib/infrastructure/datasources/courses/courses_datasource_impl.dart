import 'package:dio/dio.dart';
import 'package:gymnastic_center/domain/datasources/courses/course_datasource.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/infrastructure/core/constants/environment.dart';
import 'package:gymnastic_center/infrastructure/mappers/course_mapper.dart';
import 'package:gymnastic_center/infrastructure/models/courses/course_response.dart';

class CoursesDatasourceImpl extends CourseDatasource {
  final dio = Dio(BaseOptions(baseUrl: Environment.backendApi, headers: {
    'auth':
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjkzNWQ1MWMzLWViYzgtNDQyNy1hZDg3LTllZTY2OWNmNWU3OSIsImlhdCI6MTcxNDk1MDQ3OH0.GD_6noVQuag3jm_2t-kkqqTNX-6qytwT1jrJpJbngMw'
  }));

  @override
  Future<List<Course>> getCoursesPaginated(
      {int limit = 5, int offset = 0}) async {
    final response =
        await dio.get('/course/paginated?limit=$limit&offset=$offset');
    final List<Course> courses = [];

    for (final course in response.data ?? []) {
      final courseResponse = CourseResponse.fromJson(course);
      courses.add(CourseMapper.courseToEntity(courseResponse));
    }

    return courses;
  }

  @override
  Future<Course> getCourseById(String id) async {
    final response = await dio.get('/course/information/$id');
    final courseResponse = CourseResponse.fromJson(response.data);
    return CourseMapper.courseToEntity(courseResponse);
  }
}
