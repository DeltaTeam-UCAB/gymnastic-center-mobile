part of 'suscribe_course_bloc.dart';


enum SuscribedStatus {checking, suscribed, unsuscribed, suscribing}

class SuscribeCourseState extends Equatable {
  final SuscribedStatus status;
  const SuscribeCourseState({
    this.status = SuscribedStatus.checking
  });

  SuscribeCourseState copyWith({
    SuscribedStatus? status,
  })=>SuscribeCourseState(
    status: status ?? this.status,
  );
  
  @override
  List<Object> get props => [status];
}