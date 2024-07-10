import 'package:gymnastic_center/common/results.dart';
import 'package:gymnastic_center/domain/datasources/courses/course_datasource.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/domain/repositories/courses/courses_repository.dart';

class MockCoursesRepository extends CoursesRepository {
  final List<Course> courses;
  final bool shouldFail;
  MockCoursesRepository(this.courses, [this.shouldFail = false]);

  @override
  Future<Result<Course>> getCourseById(String id) {
    if (shouldFail) {
      return Future.value(Result.fail(Exception('An error occurred')));
    }
    if (courses.isEmpty) {
      return Future.value(Result.fail(Exception('No courses found')));
    }
    final course = courses.firstWhere((element) => element.id == id);
    return Future.value(Result.success(course));
  }

  @override
  Future<Result<List<Course>>> getCoursesPaginated(
      {int page = 1,
      int perPage = 5,
      required CourseFilter filter,
      String? trainer,
      String? category}) {
    if (shouldFail) {
      return Future.value(Result.fail(Exception('An error occurred')));
    }
    return Future.value(Result.success(courses));
  }
}
