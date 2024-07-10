import 'package:gymnastic_center/domain/entities/suscription/course_progress.dart';

abstract class SuscriptionsDatasource{
  Future<List<CourseProgress>> getSuscribedCourses(int page, { int? perPage = 5 });
  Future<CourseProgress> getTrendingCourse();
  Future<void> suscribeToCourse(String courseId);
  Future<CourseProgress> getProgressByCourseId(String courseId);
  Future<void> markCompletedProgressLesson(String courseId, String lessonId);
  Future<void> markEndProgressLesson(String courseId, String lessonId, int totalSeconds, int viewedSeconds);
  Future<void> unsuscribeCourse(String courseId);
}