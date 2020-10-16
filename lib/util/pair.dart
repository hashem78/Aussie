class Pair<A, B> {
  final A first;
  final B second;
  Pair(this.first, this.second)
      : assert(
          first != null && second != null,
          "A pair's first or second values can't be assigned null",
        );
}
