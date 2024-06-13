import 'package:gymnastic_center/common/results.dart';
import 'package:gymnastic_center/domain/datasources/courses/course_datasource.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';

abstract class CoursesRepository {
  Future<Result<List<Course>>> getCoursesPaginated(
      {int page,
      int perPage,
      required CourseFilter filter,
      String? trainer,
      String? category});

  Future<Result<Course>> getCourseById(String id);
}
