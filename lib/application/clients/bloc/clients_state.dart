part of 'clients_bloc.dart';

class ClientsState extends Equatable {
  final Client? client;
  final bool isLoading;
  final bool isError;

  const ClientsState(
      {this.client, this.isLoading = false, this.isError = false});

  ClientsState copyWith({Client? client, bool? isLoading, bool? isError}) {
    return ClientsState(
        client: client ?? this.client,
        isLoading: isLoading ?? this.isLoading,
        isError: isError ?? this.isError);
  }

  @override
  List<Object> get props => [isLoading, isError];
}

final class ClientsInitial extends ClientsState {}
