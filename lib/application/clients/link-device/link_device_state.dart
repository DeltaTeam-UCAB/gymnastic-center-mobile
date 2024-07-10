part of 'link_device_bloc.dart';

enum LinkDeviceStatus { chekingDevice, deviceCheked, linking, success, failure }

class LinkDeviceState extends Equatable {
  final bool isLinked;
  final LinkDeviceStatus status;
  const LinkDeviceState(
      {this.status = LinkDeviceStatus.chekingDevice, this.isLinked = false});

  LinkDeviceState copyWith({LinkDeviceStatus? status, bool? isLinked}) =>
      LinkDeviceState(
          status: status ?? this.status, isLinked: isLinked ?? this.isLinked);

  @override
  List<Object> get props => [status];
}
