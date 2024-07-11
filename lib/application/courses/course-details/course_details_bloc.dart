import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/core/bloc/safe_bloc.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/domain/entities/trainers/trainer.dart';
import 'package:gymnastic_center/domain/repositories/courses/courses_repository.dart';

part 'course_details_event.dart';
part 'course_details_state.dart';

final initialCourse = Course(
    id: '',
    title: '',
    description: '',
    trainer: Trainer(id: '', name: '', location: '', image: ''),
    category: '',
    image: '',
    durationWeeks: '',
    durationMinutes: '',
    tags: [],
    level: '',
    released: DateTime.now(),
    lessons: []);

class CourseDetailsBloc
    extends SafeBloc<CourseDetailsEvent, CourseDetailsState> {
  final CoursesRepository coursesRepository;

  CourseDetailsBloc(this.coursesRepository)
      : super(CourseDetailsState(course: initialCourse)) {
    on<CourseLoaded>(_onCourseLoaded);
    on<LoadingStarted>(_onLoadingStarted);
    on<ErrorOnCourseLoading>(_onErrorOnCourseLoading);
    on<RefreshCourse>(_onRefreshCourse);
  }

  void _onRefreshCourse(RefreshCourse event, Emitter<CourseDetailsState> emit) {
    final courseId = state.course.id;
    emit(CourseDetailsState(
      course: initialCourse,
    ));
    getCourseById(courseId);
  }

  void _onCourseLoaded(CourseLoaded event, Emitter<CourseDetailsState> emit) {
    emit(state.copyWith(
        course: event.course, status: CourseDetailsStatus.loaded));
  }

  void _onLoadingStarted(
      LoadingStarted event, Emitter<CourseDetailsState> emit) {
    emit(state.copyWith(status: CourseDetailsStatus.loading));
  }

  void _onErrorOnCourseLoading(
      ErrorOnCourseLoading event, Emitter<CourseDetailsState> emit) {
    emit(state.copyWith(status: CourseDetailsStatus.error));
  }

  Future<void> getCourseById(String courseId) async {
    if (state.status == CourseDetailsStatus.loading) return;
    add(LoadingStarted());
    final courseResponse = await coursesRepository.getCourseById(courseId);

    if (courseResponse.isSuccessful()) {
      final course = courseResponse.getValue();
      add(CourseLoaded(course: course));
      return;
    }
    add(ErrorOnCourseLoading());
  }

  void refreshCourse() => add(RefreshCourse());
}
