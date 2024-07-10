import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/core/bloc/safe_bloc.dart';
import 'package:gymnastic_center/domain/repositories/clients/clients_repository.dart';

part 'link_device_event.dart';
part 'link_device_state.dart';

class LinkDeviceBloc extends SafeBloc<LinkDeviceEvent, LinkDeviceState> {
  final ClientsRepository _clientsRepository;
  LinkDeviceBloc(this._clientsRepository) : super(const LinkDeviceState()) {
    on<CheckDeviceLink>(_onCheckDeviceLink);
    on<LinkDeviceStarted>(_onLinkDeviceStarted);
    on<LinkDeviceSuccess>(_onLinkDeviceSuccess);
    on<LinkDeviceFailure>(_onLinkDeviceFailure);
  }

  void _onCheckDeviceLink(
      CheckDeviceLink event, Emitter<LinkDeviceState> emit) {
    emit(state.copyWith(
        status: LinkDeviceStatus.deviceCheked, isLinked: event.isLinked));
  }

  void _onLinkDeviceStarted(
      LinkDeviceStarted event, Emitter<LinkDeviceState> emit) {
    emit(state.copyWith(status: LinkDeviceStatus.linking));
  }

  void _onLinkDeviceSuccess(
      LinkDeviceSuccess event, Emitter<LinkDeviceState> emit) {
    emit(state.copyWith(status: LinkDeviceStatus.success, isLinked: true));
  }

  void _onLinkDeviceFailure(
      LinkDeviceFailure event, Emitter<LinkDeviceState> emit) {
    emit(state.copyWith(status: LinkDeviceStatus.failure));
  }

  Future<void> checkDeviceLink(String deviceToken) async {
    final response = await _clientsRepository.checkDeviceLink(deviceToken);
    if (response.isSuccessful()) {
      final isLinked = response.getValue();
      add(CheckDeviceLink(isLinked));
    } else {
      add(LinkDeviceFailure());
    }
  }

  Future<void> linkDevice(String deviceToken) async {
    add(LinkDeviceStarted());
    final response = await _clientsRepository.linkDevice(deviceToken);
    if (response.isSuccessful()) {
      add(LinkDeviceSuccess());
    } else {
      add(LinkDeviceFailure());
    }
  }
}
