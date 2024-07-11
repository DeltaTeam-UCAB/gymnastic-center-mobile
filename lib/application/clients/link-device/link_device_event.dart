part of 'link_device_bloc.dart';

sealed class LinkDeviceEvent {
  const LinkDeviceEvent();
}

class CheckDeviceLink extends LinkDeviceEvent {
  final bool isLinked;
  const CheckDeviceLink(this.isLinked);
}

class LinkDeviceStarted extends LinkDeviceEvent {}

class LinkDeviceSuccess extends LinkDeviceEvent {}

class LinkDeviceFailure extends LinkDeviceEvent {}