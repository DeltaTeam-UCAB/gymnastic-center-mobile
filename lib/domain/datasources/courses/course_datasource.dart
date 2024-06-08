import 'package:gymnastic_center/domain/entities/courses/course.dart';

abstract class CoursesDatasource {
  Future<List<Course>> getCoursesPaginated({int page = 1, int perPage = 10});

  Future<Course> getCourseById(String id);
}
