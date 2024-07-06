import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/application/core/bloc/safe_bloc.dart';
import 'package:gymnastic_center/domain/entities/client/client.dart';
import 'package:gymnastic_center/domain/repositories/clients/clients_repository.dart';

part 'clients_event.dart';
part 'clients_state.dart';

class ClientsBloc extends SafeBloc<ClientsEvent, ClientsState> {
  final ClientsRepository clientsRepository;

  ClientsBloc(this.clientsRepository)
      : super(ClientsState(
            client: Client(id: '', name: '', phone: '', email: ''))) {
    on<ClientFetched>(_onClientFetched);
    on<CurrentClient>(_onCurrentClient);
    on<ClientsError>(_onClientsError);
    on<ClientsLoading>(_onClientsLoading);
  }

  void _onClientFetched(ClientFetched event, Emitter<ClientsState> emit) {
    emit(state.copyWith(
        client: event.client,
        isLoading: false,
        isError: false,
        isEmpty: false));
  }

  void _onCurrentClient(CurrentClient event, Emitter<ClientsState> emit) {
    emit(state.copyWith(client: event.client, isLoading: false));
  }

  void _onClientsError(ClientsError event, Emitter<ClientsState> emit) {
    emit(state.copyWith(isError: true));
  }

  void _onClientsLoading(ClientsLoading event, Emitter<ClientsState> emit) {
    emit(state.copyWith(isLoading: true, isError: false));
  }

  Future<void> getClientData() async {
    if (state.isLoading || state.isError) return;
    add(const ClientsLoading());

    final clientResponse = await clientsRepository.getClientData();

    if (clientResponse.isSuccessful()) {
      final client = clientResponse.getValue();
      add(ClientFetched(client));
    } else {
      add(const ClientsError());
    }
  }
}
