import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/infrastructure/mappers/trainer_mapper.dart';
import 'package:gymnastic_center/infrastructure/models/courses/course_response.dart';

class CourseMapper {
  static Course courseToEntity(CourseResponse json) {
    return Course(
        id: json.id,
        title: json.title,
        description: json.description,
        category: json.category,
        image: json.image,
        lessons: LessonMapper.lessonToEntity(json.lessons),
        tags: json.tags,
        level: json.level,
        released: json.date,
        trainer: TrainerMapper.trainerToEntity(json.trainer),
      );
  }
}

class LessonMapper {
  static List<Lesson> lessonToEntity(List<LessonResponse> json) {
    return json
        .map((e) => Lesson(
              id: e.id,
              title: e.title,
              content: e.content,
              videoUrl: e.video,
              imageUrl: e.image,
              order: int.parse(e.order),
            ))
        .toList();
  }
}
