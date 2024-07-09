class Optional<T> {
  T? _value;
  late bool _assigned;

  Optional(T? value) {
    _value = value;
    _assigned = _value != null;
  }

  bool hasValue() {
    return _assigned;
  }

  T getValue() {
    if (!hasValue()) {
      throw Exception("Attempted to retrieve empty optional value");
    }
    return _value!;
  }
}
