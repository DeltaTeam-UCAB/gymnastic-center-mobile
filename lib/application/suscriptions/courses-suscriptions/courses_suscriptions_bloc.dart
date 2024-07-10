import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/core/bloc/safe_bloc.dart';
import 'package:gymnastic_center/domain/entities/suscription/course_progress.dart';
import 'package:gymnastic_center/domain/repositories/suscription/suscription_repository.dart';

part 'courses_suscriptions_event.dart';
part 'courses_suscriptions_state.dart';

class CoursesSuscriptionsBloc extends SafeBloc<CoursesSuscriptionsEvent, CoursesSuscriptionsState> {
  final SuscriptionRepository suscriptionRepository; 
  CoursesSuscriptionsBloc(this.suscriptionRepository) : super(const CoursesSuscriptionsState()) {
    on<SuscribedCouresesLoaded>(_onSuscribedCoursesLoaded);
    on<CoursesUnsuscribed>(_onCoursesUnsuscribed);
    on<StartLoadingNextPage>(_onStartLoadingNextPage);
    on<ErrorOccurred>(_onErrorOccurred);
  }

  void _onSuscribedCoursesLoaded(SuscribedCouresesLoaded event, Emitter<CoursesSuscriptionsState> emit){
    emit(
      state.copyWith(
        coursesSuscribed: [...state.coursesSuscribed, ...event.coursesSuscribed],
        isLastPage: event.isLastPage,
        status: CoursesSuscriptionsStatus.loaded,
        page: event.page
      )
    );
  }

  void _onCoursesUnsuscribed(CoursesUnsuscribed event, Emitter<CoursesSuscriptionsState> emit){
    emit(
      state.copyWith(
        status: CoursesSuscriptionsStatus.initial,
        isLastPage: false,
        coursesSuscribed: [],
        page: 0
      )
    );
  }

  void _onStartLoadingNextPage(StartLoadingNextPage event, Emitter<CoursesSuscriptionsState> emit){
    emit(
      state.copyWith(
        status: CoursesSuscriptionsStatus.loading,
      )
    );
  }

  

  void _onErrorOccurred(ErrorOccurred event, Emitter<CoursesSuscriptionsState> emit){
    emit(
      state.copyWith(
        status: CoursesSuscriptionsStatus.error,
      )
    );
  }

  Future<void> loadNextPage({int perPage = 5}) async{
    if ( state.status == CoursesSuscriptionsStatus.loading || state.isLastPage)  return ;
    add(StartLoadingNextPage());
    final newCoursesSusccribedResult = await suscriptionRepository.getSuscribedCourses(state.page + 1, perPage: perPage);
    if (newCoursesSusccribedResult.isSuccessful()){
      final newCoursesSusccribed = newCoursesSusccribedResult.getValue();
      add(SuscribedCouresesLoaded(coursesSuscribed: newCoursesSusccribed, isLastPage: newCoursesSusccribed.isEmpty, page: state.page + 1));
      return ;
    }
    add(ErrorOccurred());
  }

  Future<void> initialLoading({int perPage = 5}) async{
    final newCoursesSusccribedResult = await suscriptionRepository.getSuscribedCourses(1, perPage: perPage);
    if (newCoursesSusccribedResult.isSuccessful()){
      final newCoursesSusccribed = newCoursesSusccribedResult.getValue();
      add(SuscribedCouresesLoaded(coursesSuscribed: newCoursesSusccribed, isLastPage: newCoursesSusccribed.isEmpty, page: 1));
      return ;
    }
    add(ErrorOccurred());
  }

  Future<void> unsuscribeCourse(String courseId) async{
    final unsuscribeResult = await suscriptionRepository.unsuscribeCourse(courseId);
    if ( unsuscribeResult.isSuccessful() ){
      add(CoursesUnsuscribed());
      return ;
    }
    add(ErrorOccurred());
  }

}
