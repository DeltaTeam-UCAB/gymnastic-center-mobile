class Course {
  final String id;
  final String title;
  final String description;
  final String calories;
  final String instructor;
  final String category;
  final String image;
  final DateTime? released;
  final List<Lesson>? lessons;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.calories,
    required this.instructor,
    required this.category,
    required this.image,
    this.released,
    this.lessons = const [],
  });
}

class Lesson {
  final String id;
  final String name;
  final String description;
  final String courseId;
  final String videoId;
  final String order;
  final String waitTime;
  final String burnedCalories;

  Lesson({
      required this.id,
      required this.name,
      required this.description,
      required this.courseId,
      required this.videoId,
      required this.order,
      required this.waitTime,
      required this.burnedCalories,
  });
}
