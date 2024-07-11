part of 'trainer_details_bloc.dart';

class TrainerDetailsState extends Equatable {
  final Trainer trainer;
  final int blogCount;
  final int courseCount;
  final bool isFollowing;
  final bool isLoading;
  final bool isError;

  const TrainerDetailsState({
    required this.trainer,
    this.isFollowing = false,
    this.isLoading = false,
    this.isError = false,
    this.blogCount = 0, 
    this.courseCount = 0,
  });

  TrainerDetailsState copyWith({
    Trainer? trainer,
    bool? isFollowing,
    bool? isLoading,
    bool? isError,
    int? blogCount,
    int? courseCount,
  }) {
    return TrainerDetailsState(
      trainer: trainer ?? this.trainer,
      isFollowing: isFollowing ?? this.isFollowing,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      blogCount: blogCount ?? this.blogCount,
      courseCount: courseCount ?? this.courseCount,
    );
  }

  @override
  List<Object> get props => [trainer, isFollowing, isLoading, isError, blogCount, courseCount];
}
