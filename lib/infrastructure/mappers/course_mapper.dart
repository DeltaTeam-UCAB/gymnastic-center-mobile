import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/infrastructure/models/courses/course_response.dart';

class CourseMapper {
  static Course courseToEntity(CourseResponse json) {
    return Course(
      id: json.id, 
      title: json.title, 
      description: json.description, 
      calories: json.calories, 
      instructor: json.instructor, 
      category: json.category, 
      image: json.image, 
      lessons: LessonMapper.lessonToEntity(json.lessons ?? []), 
      released: json.creationDate
    );
  }
}

class LessonMapper {
  static List<Lesson> lessonToEntity(List<LessonResponse> json) {
    return json.map((e) => Lesson(
      id: e.id, 
      name: e.name, 
      description: e.description, 
      courseId: e.courseId, 
      videoId: e.videoId, 
      order: e.order, 
      waitTime: e.waitTime, 
      burnedCalories: e.burnedCalories
    )).toList();
  }
}