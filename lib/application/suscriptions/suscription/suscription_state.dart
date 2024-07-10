part of 'suscription_bloc.dart';


enum SuscribedStatus {checking, suscribed, unsuscribed, suscribing}

class SuscriptionState extends Equatable {
  final SuscribedStatus status;
  const SuscriptionState({
    this.status = SuscribedStatus.checking
  });

  SuscriptionState copyWith({
    SuscribedStatus? status,
  })=>SuscriptionState(
    status: status ?? this.status,
  );
  
  @override
  List<Object> get props => [status];
}