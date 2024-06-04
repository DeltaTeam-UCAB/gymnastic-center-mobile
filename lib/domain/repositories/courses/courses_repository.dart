import 'package:gymnastic_center/common/results.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';

abstract class CoursesRepository {
  Future<Result<List<Course>>> getCoursesPaginated({int page = 1, int perPage = 10});

  Future<Result<Course>> getCourseById(String id);
}
