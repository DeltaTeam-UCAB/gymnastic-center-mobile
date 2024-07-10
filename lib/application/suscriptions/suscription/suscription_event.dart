part of 'suscription_bloc.dart';

sealed class SuscriptionEvent {
  const SuscriptionEvent();
}

class SuscribedStatusChecked extends SuscriptionEvent{
  final SuscribedStatus status;
  SuscribedStatusChecked(this.status);
}
