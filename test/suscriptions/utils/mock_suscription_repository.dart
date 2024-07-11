import 'package:gymnastic_center/common/results.dart';
import 'package:gymnastic_center/domain/entities/suscription/course_progress.dart';
import 'package:gymnastic_center/domain/repositories/suscription/suscription_repository.dart';

class MockSuscriptionRepository extends SuscriptionRepository {
  final List<CourseProgress> coursesProgress;
  final bool shouldFail;
  MockSuscriptionRepository(this.coursesProgress, [this.shouldFail = false]);
  @override
  Future<Result<CourseProgress>> getProgressByCourseId(String courseId) {
    if (coursesProgress.isEmpty || shouldFail) {
      return Future.value(Result.fail(Exception('No coursesProgress found')));
    }
    final course =
        coursesProgress.firstWhere((element) => element.courseId == courseId);
    return Future.value(Result.success(course));
  }

  @override
  Future<Result<List<CourseProgress>>> getSuscribedCourses(int page,
      {int? perPage = 10}) {
    if (coursesProgress.isEmpty) {
      return Future.value(Result.success([]));
    }
    if (shouldFail) {
      return Future.value(Result.fail(Exception()));
    }
    return Future.value(Result.success(
        coursesProgress.sublist(perPage! * (page - 1), perPage * page)));
  }

  @override
  Future<Result<CourseProgress>> getTrendingCourse() {
    if (coursesProgress.isNotEmpty) {
      return Future.value(Result.success(coursesProgress.first));
    }
    return Future.value(Result.fail(Exception('Suscription not found')));
  }

  @override
  Future<Result<bool>> markCompletedProgressLesson(
      String courseId, String lessonId) {
    return Future.value(Result.success(true));
  }

  @override
  Future<Result<bool>> markEndProgressLesson(
      String courseId, String lessonId, int totalSeconds, int secondsViewed) {
    return Future.value(Result.success(true));
  }

  @override
  Future<Result<bool>> suscribeToCourse(String courseId) {
    if (shouldFail) {
      return Future.value(Result.fail(Exception('No coursesProgress found')));
    }
    coursesProgress.firstWhere((element) => element.courseId == courseId);
    return Future.value(Result.success(true));
  }

  @override
  Future<Result<bool>> unsuscribeCourse(String courseId) {
    if (coursesProgress.isEmpty || shouldFail) {
      return Future.value(Result.fail(Exception('No coursesProgress found')));
    }
    coursesProgress.firstWhere((element) => element.courseId == courseId);
    return Future.value(Result.success(true));
  }

  @override
  Future<Result<int>> getSuscribedCoursesCount() {
    if (shouldFail) {
      return Future.value(Result.fail(Exception('Error loading profile')));
    }
    return Future.value(Result.success(10));
  }
}
