class ErrorCoordinate implements Exception {
  final String who;
  final int coordinate;
  ErrorCoordinate(this.who, this.coordinate);

  @override
  String toString() {
    return "Error: $who > 2 ($coordinate)";
  }
}
