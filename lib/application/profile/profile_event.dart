part of 'profile_bloc.dart';

sealed class ProfileEvent {
  const ProfileEvent();
}

class ProfileLoaded extends ProfileEvent {
  final int suscribedCourses;
  final int followingTrainers;
  const ProfileLoaded(this.suscribedCourses, this.followingTrainers);
}

class ProfileLoading extends ProfileEvent {
  const ProfileLoading();
}

class ProfileError extends ProfileEvent {
  const ProfileError();
}
