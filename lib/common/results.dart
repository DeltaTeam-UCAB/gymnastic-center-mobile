class Result<T> {
  final T? value;
  final Exception? error;
  final bool isSuccess;

  Result._({this.value, this.error, required this.isSuccess})
      : assert(value != null || error != null,
            'Either value or error must be provided');
  bool isSuccessful() => isSuccess;

  T getValue() {
    if (!isSuccess) throw error!;
    return value!;
  }

  Exception getError() {
    if (isSuccess) throw Exception('Result is successful');
    return error!;
  }

  factory Result.success(T value) => Result._(value: value, isSuccess: true);

  factory Result.fail(Exception error) =>
      Result._(error: error, isSuccess: false);
}
