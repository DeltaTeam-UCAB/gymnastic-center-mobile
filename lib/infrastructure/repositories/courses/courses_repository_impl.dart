import 'package:gymnastic_center/common/results.dart';
import 'package:gymnastic_center/domain/datasources/courses/course_datasource.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/domain/repositories/courses/courses_repository.dart';

class CoursesRepositoryImpl extends CoursesRepository {
  final CoursesDatasource coursesDataSource;

  CoursesRepositoryImpl(this.coursesDataSource);

  @override
  Future<Result<Course>> getCourseById(String id) async {
    try {
      final course = await coursesDataSource.getCourseById(id);
      return Result<Course>.success(course);
    } catch (error, _) {
      return Result<Course>.fail(error as Exception);
    }
  }

  @override
  Future<Result<List<Course>>> getCoursesPaginated(
      {page = 1,
      perPage = 10,
      required CourseFilter filter,
      String? trainer,
      String? category}) async {
    try {
      final courses = await coursesDataSource.getCoursesPaginated(
          page: page,
          perPage: perPage,
          filter: filter,
          trainer: trainer,
          category: category);
      return Result<List<Course>>.success(courses);
    } catch (error, _) {
      return Result<List<Course>>.fail(error as Exception);
    }
  }
}
