part of 'trainer_bloc.dart';

class TrainerState extends Equatable {
  final Trainer trainer;
  final bool isFollowing;
  final bool isLoading;
  final bool isError;

  const TrainerState({
    required this.trainer,
    this.isFollowing = false,
    this.isLoading = false,
    this.isError = false,
  });

  TrainerState copyWith({
    Trainer? trainer,
    bool? isFollowing,
    bool? isLoading,
    bool? isError,
  }) {
    return TrainerState(
      trainer: trainer ?? this.trainer,
      isFollowing: isFollowing ?? this.isFollowing,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }

  @override
  List<Object> get props => [trainer, isFollowing, isLoading, isError];
}
