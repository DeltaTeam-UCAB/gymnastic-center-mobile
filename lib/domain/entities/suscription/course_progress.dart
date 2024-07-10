class CourseProgress{
  final String courseId;
  final String courseTitle;
  final String trainer;
  final String image;
  final int percent;
  final DateTime lastTime;
  final List<LessonsProgress> lessons;

  CourseProgress({
      required this.courseTitle,
      required this.percent,
      required this.lastTime,
      required this.courseId,
      required this.lessons,
      required this.image,
      required this.trainer
  });
}

class LessonsProgress {
  final String lessonId;
  final Duration time;
  final int percent;

  const LessonsProgress({
    required this.lessonId,
    required this.time,
    required this.percent
  });
}