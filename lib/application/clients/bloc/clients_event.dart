part of 'clients_bloc.dart';

sealed class ClientsEvent {
  const ClientsEvent();
}

class ClientFetched extends ClientsEvent {
  final Client client;
  const ClientFetched(this.client);
}

class ClientsLoading extends ClientsEvent {
  const ClientsLoading();
}

class ClientsError extends ClientsEvent {
  const ClientsError();
}

class CurrentClient extends ClientsEvent {
  final Client? client;
  const CurrentClient(this.client);
}
