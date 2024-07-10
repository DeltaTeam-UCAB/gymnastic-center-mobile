
class CourseProgressApiResponse {
    final String courseId;
    final String courseTitle;
    final double percent;
    final DateTime lastTime;
    final List<LessonProgressApiResponse> lessons;
    final String trainer;
    final String image;

    CourseProgressApiResponse({
        required this.courseTitle,
        required this.percent,
        required this.lastTime,
        required this.courseId,
        required this.lessons,
        required this.trainer,
        required this.image,
    });
    
    factory CourseProgressApiResponse.fromJson(Map<String, dynamic> json) => CourseProgressApiResponse(
        courseTitle: json["courseTitle"] ?? json["title"] ?? '',
        percent: (json["percent"] ?? json["progress"]).toDouble(),
        lastTime: json["lastTime"] != null ? DateTime.parse(json["lastTime"]) : DateTime.now(),
        courseId: json["courseId"] ?? json["id"] ?? '',
        trainer: json["trainer"] ?? '',
        image: json["image"] ?? '',
        lessons: List<LessonProgressApiResponse>.from((json["lessons"] ?? []).map((x) => LessonProgressApiResponse.fromJson(x))),
    );
}

class LessonProgressApiResponse {
    final String lessonId;
    final double percent;
    final Duration time;

    LessonProgressApiResponse({
        required this.lessonId,
        required this.percent,
        required this.time,
    });

    factory LessonProgressApiResponse.fromJson(Map<String, dynamic> json) => LessonProgressApiResponse(
        lessonId: json["lessonId"],
        percent: (json["percent"]).toDouble(),
        time: Duration(seconds: (json['time'] ?? 0).toInt()),
    );
}
