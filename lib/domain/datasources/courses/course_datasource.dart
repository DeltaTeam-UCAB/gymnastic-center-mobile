import 'package:gymnastic_center/domain/entities/courses/course.dart';

enum CourseFilter { popular, recent }

abstract class CoursesDatasource {
  Future<List<Course>> getCoursesPaginated(
      {int page,
      int perPage,
      required CourseFilter filter,
      String? trainer,
      String? category});

  Future<Course> getCourseById(String id);
  Future<String> deleteCourse(String courseId);
}
