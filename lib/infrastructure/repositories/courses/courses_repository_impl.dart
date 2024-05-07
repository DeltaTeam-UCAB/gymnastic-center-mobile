import 'package:gymnastic_center/application/core/results.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/domain/repositories/courses/courses_repository.dart';
import 'package:gymnastic_center/infrastructure/datasources/courses/courses_datasource_impl.dart';

class CoursesRepositoryImpl extends CoursesRepository {
  final CoursesDatasourceImpl coursesDataSource;

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
  Future<Result<List<Course>>> getCoursesPaginated({int limit = 5, int offset = 0}) async {
    try {
      final courses = await coursesDataSource.getCoursesPaginated(limit: limit, offset: offset);
      return Result<List<Course>>.success(courses);
    } catch (error, _) {
      return Result<List<Course>>.fail(error as Exception);
    }
  }
}