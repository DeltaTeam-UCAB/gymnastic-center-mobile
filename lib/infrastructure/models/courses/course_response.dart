class CourseResponse {
  final String id;
  final String title;
  final String description;
  final String calories;
  final String instructor;
  final String category;
  final String image;
  final List<LessonResponse>? lessons;
  final DateTime? creationDate;

  CourseResponse({
    required this.id,
    required this.title,
    required this.description,
    required this.calories,
    required this.instructor,
    required this.category,
    required this.image,
    this.lessons,
    this.creationDate,
  });

  factory CourseResponse.fromJson(Map<String, dynamic> json) => CourseResponse(
        id: json["id"] ?? "",
        title: json["title"],
        description: json["description"],
        calories: json["calories"],
        instructor: json["instructor"],
        category: json["category"],
        image: json["image"] is String
            ? json["image"]
            : ImageResponse.fromJson(json["image"]).src,
        creationDate: json["creationDate"] != null
            ? DateTime.parse(json["creationDate"])
            : null,
        lessons: json["lessons"] != null
            ? List<LessonResponse>.from(
                json["lessons"].map((x) => LessonResponse.fromJson(x)))
            : null,
      );
}

class LessonResponse {
  final String id;
  final String name;
  final String description;
  final String courseId;
  final String videoId;
  final String order;
  final String waitTime;
  final String burnedCalories;

  LessonResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.courseId,
    required this.videoId,
    required this.order,
    required this.waitTime,
    required this.burnedCalories,
  });

  factory LessonResponse.fromJson(Map<String, dynamic> json) => LessonResponse(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        courseId: json["courseId"],
        videoId: json["videoId"],
        order: json["order"],
        waitTime: json["waitTime"],
        burnedCalories: json["burnedCalories"],
      );
}

class ImageResponse {
  final String id;
  final String src;

  ImageResponse({
    required this.id,
    required this.src,
  });

  factory ImageResponse.fromJson(Map<String, dynamic> json) => ImageResponse(
    id: json["id"],
    src: json["src"],
  );
}
