class Either<L, R> {
  Either({L? left, R? right}) {
    this._left = left;
    this._right = right;
  }

  L? _left;
  R? _right;

  bool isLeft() {
    return _left != null;
  }

  bool isRight() {
    return _right != null;
  }

  L getLeft() {
    if (_left == null) throw Exception('Either.left is empty');
    return _left!;
  }

  R getRight() {
    if (_right == null) throw Exception('Either.right is empty');
    return _right!;
  }

  static Either<L, R> left<L, R>(L value) {
    return Either(left: value);
  }

  static Either<L, R> right<L, R>(R value) {
    return Either(right: value);
  }
}
