import 'package:dio/dio.dart';
import 'package:gymnastic_center/common/results.dart';
import 'package:gymnastic_center/domain/datasources/suscription/suscription_datasource.dart';
import 'package:gymnastic_center/domain/entities/suscription/course_progress.dart';
import 'package:gymnastic_center/domain/repositories/suscription/suscription_repository.dart';

class SuscriptionRepositoryImpl extends SuscriptionRepository {
  final SuscriptionsDatasource suscriptionsDatasource;

  SuscriptionRepositoryImpl(this.suscriptionsDatasource);

  @override
  Future<Result<CourseProgress>> getProgressByCourseId(String courseId) async {
    try {
      final courseProgress =
          await suscriptionsDatasource.getProgressByCourseId(courseId);
      return Result.success(courseProgress);
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<bool>> suscribeToCourse(String courseId) async {
    try {
      await suscriptionsDatasource.suscribeToCourse(courseId);
      return Result.success(true);
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<bool>> markCompletedProgressLesson(
      String courseId, String lessonId) async {
    try {
      await suscriptionsDatasource.markCompletedProgressLesson(
          courseId, lessonId);
      return Result.success(true);
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<bool>> markEndProgressLesson(String courseId, String lessonId,
      int totalSeconds, int secondsViewed) async {
    try {
      await suscriptionsDatasource.markEndProgressLesson(
          courseId, lessonId, totalSeconds, secondsViewed);
      return Result.success(true);
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<List<CourseProgress>>> getSuscribedCourses(int page,
      {int? perPage = 5}) async {
    try {
      final coursesSuscribed = await suscriptionsDatasource
          .getSuscribedCourses(page, perPage: perPage);
      return Result.success(coursesSuscribed);
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<bool>> unsuscribeCourse(String courseId) async {
    try {
      await suscriptionsDatasource.unsuscribeCourse(courseId);
      return Result.success(true);
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<CourseProgress>> getTrendingCourse() async {
    try {
      final courseProgress = await suscriptionsDatasource.getTrendingCourse();
      return Result.success(courseProgress);
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<int>> getSuscribedCoursesCount() async {
    try {
      final result = await suscriptionsDatasource.getSuscribedCoursesCount();
      return Result.success(result);
    } catch (error, _) {
      if (error is DioException && error.response?.statusCode == 404) {
        return Result.success(0);
      }
      return Result.fail(error as Exception);
    }
  }
}
