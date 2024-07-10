import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/core/bloc/safe_bloc.dart';
import 'package:gymnastic_center/domain/entities/suscription/course_progress.dart';
import 'package:gymnastic_center/domain/repositories/suscription/suscription_repository.dart';

part 'course_progress_event.dart';
part 'course_progress_state.dart';


class CourseProgressBloc extends SafeBloc<CourseProgressEvent, CourseProgressState> {

  final SuscriptionRepository suscriptionRepository;

  CourseProgressBloc(this.suscriptionRepository) : super(const CourseProgressState()) {
    on<CurrentCourseProgressLoaded>(_onCurrentCourseProgressLoaded);
    on<CurrentCourseProgressCompleted>(_onCurrentCourseProgressCompleted);
    on<CurrentCourseProgressEnded>(_onCurrentCourseProgressEnded);
    on<ErrorOccurred>(_onErrorOcurred);
  }
  // 
  void _onCurrentCourseProgressLoaded(CurrentCourseProgressLoaded event, Emitter<CourseProgressState> emit){
    emit(
      state.copyWith(
        coursePercent: event.courseProgress.percent.round(),
        lessonsProgress: event.courseProgress.lessons,
        status: CourseProgressStatus.loaded
      )
    );
  }

  void _onCurrentCourseProgressCompleted(CurrentCourseProgressCompleted event, Emitter<CourseProgressState> emit){
    final newCoursePercent = _calculateNewCoursePercent(event.lessonId, 100);
    emit(
      state.copyWith(
        coursePercent: newCoursePercent,
        lessonsProgress: state.lessonsProgress.map(
          (lesson) => 
            ( lesson.lessonId == event.lessonId )
            ?  LessonsProgress(lessonId: lesson.lessonId, percent: 100, time: const Duration( seconds: 0 ))
            : lesson
        ).toList()
      )
    );
  }

  void _onCurrentCourseProgressEnded(CurrentCourseProgressEnded event, Emitter<CourseProgressState> emit){
    final newCoursePercent = _calculateNewCoursePercent(event.lessonId, event.newPercent);
    emit(
      state.copyWith(
        coursePercent: newCoursePercent,
        lessonsProgress: state.lessonsProgress.map(
          (lesson) => 
            ( lesson.lessonId == event.lessonId )
            ?  LessonsProgress(
                lessonId: lesson.lessonId,
                percent: event.newPercent,
                time: Duration( seconds: event.viewSeconds )
              )
            : lesson
        ).toList()
      )
    );
  }

  void _onErrorOcurred(ErrorOccurred event, Emitter<CourseProgressState> emit){
    emit(
      state.copyWith(
        status: CourseProgressStatus.error
      )
    );
  }

  Future<void> loadCurrentCourseProgressById(String courseId) async{
    final result = await suscriptionRepository.getProgressByCourseId(courseId);
    if (result.isSuccessful()){
      add(CurrentCourseProgressLoaded(result.getValue()));
      return ;
    }
    add(ErrorOccurred());
  }

  void markEndLesson(String courseId, String lessonId, int totalSeconds, int secondsViewed){
    final lessonProgressPercent = state.lessonsProgress.firstWhere((element) => element.lessonId == lessonId).percent;
    final newPercent = ((secondsViewed * 100)  ~/  totalSeconds).toInt();
    if ( lessonProgressPercent > newPercent ) return;
    suscriptionRepository.markEndProgressLesson(courseId, lessonId, totalSeconds, secondsViewed);
    add(CurrentCourseProgressEnded(newPercent, lessonId, secondsViewed));
  }
  
  void markCompletedLesson(String courseId, String lessonId) async{
    suscriptionRepository.markCompletedProgressLesson(courseId, lessonId);
    add(CurrentCourseProgressCompleted(lessonId));
  }
  int _calculateNewCoursePercent(String lessonIdUpdated, int newLessonPercent){
    var newCoursePercent = 0;
    for (final lesson in state.lessonsProgress) {
      if ( lesson.lessonId == lessonIdUpdated) {
        newCoursePercent += newLessonPercent;
      } else {
        newCoursePercent += lesson.percent;
      }
    }
    return newCoursePercent ~/= state.lessonsProgress.length;
  }
}
