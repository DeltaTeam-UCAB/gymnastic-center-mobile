import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/application/core/bloc/safe_bloc.dart';
import 'package:gymnastic_center/domain/repositories/suscription/suscription_repository.dart';
import 'package:gymnastic_center/domain/repositories/trainers/trainers_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends SafeBloc<ProfileEvent, ProfileState> {
  final SuscriptionRepository suscriptionRepository;
  final TrainersRepository trainersRepository;
  ProfileBloc(
      {required this.suscriptionRepository, required this.trainersRepository})
      : super(const ProfileState(suscribedCourses: 0, followingTrainers: 0)) {
    on<ProfileLoaded>(_onProfileLoaded);
    on<ProfileLoading>(_onProfileLoading);
    on<ProfileError>(_onProfileError);
  }

  void _onProfileLoaded(ProfileLoaded event, Emitter<ProfileState> emit) {
    emit(state.copyWith(
        suscribedCourses: event.suscribedCourses,
        followingTrainers: event.followingTrainers,
        isLoading: false));
  }

  void _onProfileLoading(ProfileLoading event, Emitter<ProfileState> emit) {
    emit(state.copyWith(isLoading: true, isError: false));
  }

  void _onProfileError(ProfileError event, Emitter<ProfileState> emit) {
    emit(state.copyWith(isLoading: false, isError: true));
  }

  void loadProfileData() async {
    if (state.isLoading || state.isError) return;
    add(const ProfileLoading());

    final followingTrainersResult =
        await trainersRepository.getFollowingTrainersCount();
    final suscribedCoursesResult =
        await suscriptionRepository.getSuscribedCoursesCount();
    if (followingTrainersResult.isSuccessful() &&
        suscribedCoursesResult.isSuccessful()) {
      final followingTrainers = followingTrainersResult.getValue();
      final suscribedCourses = suscribedCoursesResult.getValue();
      add(ProfileLoaded(suscribedCourses, followingTrainers));
    } else {
      add(const ProfileError());
    }
  }
}
