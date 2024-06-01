import 'package:gymnastic_center/common/results.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';

abstract class CoursesRepository {
  Future<Result<List<Course>>> getCoursesPaginated(
      {int limit = 5, int offset = 0});

  Future<Result<Course>> getCourseById(String id);
}
