import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/domain/repositories/courses/courses_repository.dart';

part 'lessons_event.dart';
part 'lessons_state.dart';

class LessonsBloc extends Bloc<LessonsEvent, LessonsState> {

  final CoursesRepository coursesRepository;

  LessonsBloc({
    required this.coursesRepository
  }) : super(const LessonsState()) {
    on<LessonsLoaded>(_onLessonsLoaded);
    on<CurrentLessonChanged>(_onCurrentLessonChanged);
    on<ErrorOcurred>(_onErrorOccurred);

  }

  void _onLessonsLoaded(
      LessonsLoaded event, Emitter<LessonsState> emit) {
    emit(
      state.copyWith(
        status: LessonsStatus.changingCLesson,
        lessons: event.lessons,
        imgSelectedCourse: event.imgSelectedCourse,
        selectedCourseId: event.selectedCourseId,
      )
    );
  }

  void _onCurrentLessonChanged(
      CurrentLessonChanged event, Emitter<LessonsState> emit) {
    emit(
      state.copyWith(
        status: LessonsStatus.loaded,
        currentLesson: event.lesson,
        isFirstLesson: event.isFirstLesson,
        isLastLesson: event.isLastLesson,
      )
    );
  }

  void _onErrorOccurred(
      ErrorOcurred event, Emitter<LessonsState> emit) {
    emit(
      state.copyWith(
        status: LessonsStatus.error,
      )
    );
  }

  void loadLessonsByCourseId(String courseId) async{
    final courseResult = await coursesRepository.getCourseById(courseId);
    if ( courseResult.isSuccessful() ){
      final course = courseResult.getValue();
      final lessons = course.lessons!;
      add(LessonsLoaded(lessons, course.id, course.image));
      return ;
    }
    return ;
  }

  void changeCurrentLesson(String lessonId){
    //TODO : cambiar en un futuro
    final lesson = state.lessons.where((l) => l.id == lessonId);
    if ( lesson.isNotEmpty ){
      final newLesson = lesson.toList()[0];
      add(CurrentLessonChanged(
          newLesson,
          state.lessons.first == newLesson,
          state.lessons.last == newLesson,
        )
      );
      return;
    }
    add(const ErrorOcurred());
  }

  void changeToNextLesson(){
    if (state.isLastLesson) return ;
    final lesson = state.lessons.where((l) => l.order == (state.currentLesson.order + 1));
    if ( lesson.isNotEmpty ){
      final newLesson = lesson.toList()[0];
      add(
        CurrentLessonChanged(
          newLesson,
          state.lessons.first == newLesson,
          state.lessons.last == newLesson,
        )
      );
      return;
    }
    add(const ErrorOcurred());
  }
  void changeToPreviousLesson(){
    if (state.isFirstLesson) return ;
    final lesson = state.lessons.where((l) => l.order == (state.currentLesson.order - 1));
    if ( lesson.isNotEmpty ){
      final newLesson = lesson.toList()[0];
      add(CurrentLessonChanged(
          newLesson,
          state.lessons.first == newLesson,
          state.lessons.last == newLesson,
        )
      );
      return;
    }
    add(const ErrorOcurred());
  }
}
