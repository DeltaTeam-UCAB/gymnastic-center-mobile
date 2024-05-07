class Course {
  final String id;
  final String title;
  final String description;
  final String instructor;
  final String calories;
  final DateTime? released;
  final String category;
  final String image;
  final List<Lesson>? lessons;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.calories,
    required this.instructor,
    required this.category,
    required this.image,
    required this.lessons,
    required this.released,
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