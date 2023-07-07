enum LanderInstruction {
  left("L"),
  rigth("R"),
  forward("F");

  final String symbol;

  const LanderInstruction(this.symbol);

  static Map<String, LanderInstruction> instructionMap = Map.unmodifiable(
    Map.fromEntries(
      values.map((instruction) => MapEntry(instruction.symbol, instruction)),
    ),
  );
}
