enum CardinalDirection {
  north("N"),
  east("E"),
  south("S"),
  west("W");

  final String symbol;

  const CardinalDirection(this.symbol);

  static Map<String, CardinalDirection> symbolMap = Map.unmodifiable(
    Map.fromEntries(
      values.map((direction) => MapEntry(direction.symbol, direction)),
    ),
  );
}
