import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/core/bloc/safe_bloc.dart';
import 'package:gymnastic_center/domain/entities/suscription/course_progress.dart';
import 'package:gymnastic_center/domain/repositories/suscription/suscription_repository.dart';

part 'trending_progress_event.dart';
part 'trending_progress_state.dart';

final initialCourseProgress = CourseProgress(
  courseTitle: '',
  percent: 0,
  lastTime: DateTime.now(),
  courseId: '',
  lessons: [],
  image: '',
  trainer: ''
);

class TrendingProgressBloc extends SafeBloc<TrendingProgressEvent, TrendingProgressState> {
  final SuscriptionRepository suscriptionRepository;
  TrendingProgressBloc(this.suscriptionRepository) : super(TrendingProgressState(trendingCourseProgress: initialCourseProgress)) {
    on<TrendingCourseProgressLoaded>(_onTrendingCourseProgressLoaded);
    on<ErrorOccurred>(_onErrorOccurred);
  }

  void _onTrendingCourseProgressLoaded(TrendingCourseProgressLoaded event, Emitter<TrendingProgressState> emit){
    emit(
      state.copyWith(
        status: TrendingProgressStatus.loaded,
        trendingCourseProgress: event.courseProgress
      )
    );
  }

  void _onErrorOccurred(ErrorOccurred event, Emitter<TrendingProgressState> emit){
    emit(
      state.copyWith(
        status: TrendingProgressStatus.error,
      )
    );
  }

  Future<void> loadTrendingCourseProgress() async {
    final courseProgressResult = await suscriptionRepository.getTrendingCourse();
    if (courseProgressResult.isSuccessful()){
      add(TrendingCourseProgressLoaded(courseProgressResult.getValue()));
      return ;
    }
    add(ErrorOccurred());
  }
}
