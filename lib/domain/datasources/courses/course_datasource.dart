import 'package:gymnastic_center/domain/entities/courses/course.dart';

abstract class CourseDatasource {
  Future<List<Course>> getCoursesPaginated({int limit = 5, int offset = 0});

  Future<Course> getCourseById(String id);
}