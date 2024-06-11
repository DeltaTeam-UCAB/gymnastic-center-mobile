part of 'clients_bloc.dart';

class ClientsState extends Equatable {
  final Client client;
  final bool isLoading;
  final bool isError;
  final bool isEmpty;

  const ClientsState(
      {required this.client,
      this.isLoading = false,
      this.isError = false,
      this.isEmpty = true});

  ClientsState copyWith(
      {Client? client, bool? isLoading, bool? isError, bool? isEmpty}) {
    return ClientsState(
        client: client ?? this.client,
        isLoading: isLoading ?? this.isLoading,
        isError: isError ?? this.isError,
        isEmpty: isEmpty ?? this.isEmpty);
  }

  @override
  List<Object> get props => [isLoading, isError, isEmpty];
}
