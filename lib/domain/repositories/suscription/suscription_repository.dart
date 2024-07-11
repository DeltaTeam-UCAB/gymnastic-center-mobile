import 'package:gymnastic_center/common/results.dart';
import 'package:gymnastic_center/domain/entities/suscription/course_progress.dart';

abstract class SuscriptionRepository {
  Future<Result<List<CourseProgress>>> getSuscribedCourses(int page,
      {int? perPage = 5});
  Future<Result<CourseProgress>> getTrendingCourse();
  Future<Result<bool>> suscribeToCourse(String courseId);
  Future<Result<CourseProgress>> getProgressByCourseId(String courseId);
  Future<Result<bool>> markCompletedProgressLesson(
      String courseId, String lessonId);
  Future<Result<bool>> markEndProgressLesson(
      String courseId, String lessonId, int totalSeconds, int secondsViewed);
  Future<Result<bool>> unsuscribeCourse(String courseId);
  Future<Result<int>> getSuscribedCoursesCount();
}
