part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final int suscribedCourses;
  final int followingTrainers;
  final bool isLoading;
  final bool isError;

  const ProfileState({
    this.suscribedCourses = 0,
    this.followingTrainers = 0,
    this.isLoading = false,
    this.isError = false,
  });

  ProfileState copyWith(
      {int? suscribedCourses,
      int? followingTrainers,
      bool? isLoading,
      bool? isError}) {
    return ProfileState(
        suscribedCourses: suscribedCourses ?? this.suscribedCourses,
        followingTrainers: followingTrainers ?? this.followingTrainers,
        isLoading: isLoading ?? this.isLoading,
        isError: isError ?? this.isError);
  }

  @override
  List<Object> get props =>
      [suscribedCourses, followingTrainers, isLoading, isError];
}
