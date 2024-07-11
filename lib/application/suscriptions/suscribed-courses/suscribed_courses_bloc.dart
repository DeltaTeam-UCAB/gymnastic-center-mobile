import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/core/bloc/safe_bloc.dart';
import 'package:gymnastic_center/domain/entities/suscription/course_progress.dart';
import 'package:gymnastic_center/domain/repositories/suscription/suscription_repository.dart';

part 'suscribed_courses_event.dart';
part 'suscribed_courses_state.dart';

class SuscribedCoursesBloc extends SafeBloc<SuscribedCoursesEvent, SuscribedCoursesState> {
  final SuscriptionRepository suscriptionRepository; 
  SuscribedCoursesBloc(this.suscriptionRepository) : super(const SuscribedCoursesState()) {
    on<SuscribedCouresesLoaded>(_onSuscribedCoursesLoaded);
    on<CoursesUnsuscribed>(_onCoursesUnsuscribed);
    on<StartLoadingNextPage>(_onStartLoadingNextPage);
    on<ErrorOccurred>(_onErrorOccurred);
  }

  void _onSuscribedCoursesLoaded(SuscribedCouresesLoaded event, Emitter<SuscribedCoursesState> emit){
    emit(
      state.copyWith(
        coursesSuscribed: [...state.coursesSuscribed, ...event.coursesSuscribed],
        isLastPage: event.isLastPage,
        status: SuscribedCoursesStatus.loaded,
        page: event.page
      )
    );
  }

  void _onCoursesUnsuscribed(CoursesUnsuscribed event, Emitter<SuscribedCoursesState> emit){
    emit(
      state.copyWith(
        status: SuscribedCoursesStatus.initial,
        isLastPage: false,
        coursesSuscribed: [],
        page: 0
      )
    );
  }

  void _onStartLoadingNextPage(StartLoadingNextPage event, Emitter<SuscribedCoursesState> emit){
    emit(
      state.copyWith(
        status: SuscribedCoursesStatus.loading,
      )
    );
  }

  

  void _onErrorOccurred(ErrorOccurred event, Emitter<SuscribedCoursesState> emit){
    emit(
      state.copyWith(
        status: SuscribedCoursesStatus.error,
      )
    );
  }

  Future<void> loadNextPage({int perPage = 5}) async{
    if ( state.status == SuscribedCoursesStatus.loading || state.isLastPage)  return ;
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
