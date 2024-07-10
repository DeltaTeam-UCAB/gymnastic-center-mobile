import 'package:gymnastic_center/domain/entities/suscription/course_progress.dart';
import 'package:gymnastic_center/infrastructure/models/suscriptions/course_progress_apiresponse.dart';

class CourseProgressMapper{
  static CourseProgress apiResponsetoEntity(CourseProgressApiResponse courseProgressResponse)
    => CourseProgress(
      courseId: courseProgressResponse.courseId,
      courseTitle: courseProgressResponse.courseTitle,
      percent: courseProgressResponse.percent.toInt(),
      lastTime: courseProgressResponse.lastTime,
      trainer: courseProgressResponse.trainer,
      image: courseProgressResponse.image,
      lessons: courseProgressResponse.lessons.map(
        (e) => LessonsProgress(
          time: e.time,
          lessonId: e.lessonId,
          percent: e.percent.toInt()
        )
      ).toList()
    );
}

