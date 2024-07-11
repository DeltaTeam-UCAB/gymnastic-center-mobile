part of 'lessons_bloc.dart';

enum LessonsStatus {
  loading, 
  error,
  changingLesson,
  loaded
}

class LessonsState extends Equatable {

  final String selectedCourseId;
  final String imgSelectedCourse;
  final Lesson currentLesson;
  final List<Lesson> lessons;
  final LessonsStatus status;
  final bool isLastLesson;
  final bool isFirstLesson;


  const LessonsState({
    this.selectedCourseId = '',
    this.imgSelectedCourse = '',
    this.currentLesson = const Lesson(id: '', title: '', content: '', video: '', order: 0),
    this.lessons = const [],
    this.status = LessonsStatus.loading,
    this.isLastLesson = false,
    this.isFirstLesson = false
  });

  LessonsState copyWith({
    String? selectedCourseId,
    String? imgSelectedCourse,
    Lesson? currentLesson,
    List<Lesson>? lessons,
    LessonsStatus? status,
    bool? isLastLesson,
    bool? isFirstLesson

  }) =>
      LessonsState(
        selectedCourseId: selectedCourseId ?? this.selectedCourseId,
        imgSelectedCourse: imgSelectedCourse ?? this.imgSelectedCourse,
        currentLesson: currentLesson ?? this.currentLesson,
        lessons : lessons ?? this.lessons,
        status : status ?? this.status,
        isLastLesson : isLastLesson ?? this.isLastLesson,
        isFirstLesson : isFirstLesson ?? this.isFirstLesson
      );
  
  @override
  List<Object> get props => [selectedCourseId, imgSelectedCourse, currentLesson, lessons, status, isLastLesson, isFirstLesson];
}

