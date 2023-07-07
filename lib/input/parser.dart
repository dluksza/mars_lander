import 'package:mars_lander/navigation/cardinal_direction.dart';
import 'package:mars_lander/navigation/lander_instruction.dart';
import 'package:mars_lander/navigation/lander_location.dart';

class UserInputException implements Exception {
  final String message;

  UserInputException(this.message);

  @override
  String toString() {
    return 'UserInputError($message)';
  }
}

(int, int) parseMarsSize(String input, {int maxValue = 50}) {
  final inputs = input.split(RegExp('\\s'));
  if (inputs.length != 2) {
    throw UserInputException('Invalid format of Mars size input');
  }

  final [maybeX, maybeY] = inputs;
  final x = _parseCoordinate(maybeX, maxValue);
  final y = _parseCoordinate(maybeY, maxValue);

  if (x < 1 || y < 1) {
    throw UserInputException('Mars size cannot be negative');
  }

  return (x, y);
}

LanderLocation parseLanderStartPosition(String input, {int maxValue = 50}) {
  final inputs = input.split(RegExp('\\s'));
  if (inputs.length != 3) {
    throw UserInputException('Invalid format of lander initial location');
  }

  final [maybeX, maybeY, maybeOrientation] = inputs;
  final x = _parseCoordinate(maybeX, maxValue);
  final y = _parseCoordinate(maybeY, maxValue);
  final orientation = _parseOrientation(maybeOrientation);

  return LanderLocation(x: x, y: y, orientation: orientation);
}

List<LanderInstruction> parseLanderInstructions(String input,
    {int maxInstructions = 100}) {
  if (input.length > maxInstructions) {
    throw UserInputException(
      'Mars lander can only take $maxInstructions instructions, but ${input.length} was given',
    );
  }

  return _parseInstructions(input);
}

int _parseCoordinate(String maybeCoordinate, int maxValue) {
  final coordinate = int.tryParse(maybeCoordinate);
  if (coordinate == null) {
    throw UserInputException('Cannot parse "$maybeCoordinate"');
  }

  if (coordinate < 0) {
    throw UserInputException('Coordinate cannot be negative number');
  }

  if (coordinate > maxValue) {
    throw UserInputException(
        'Value $coordinate is greater than maximum allowed of $maxValue');
  }

  return coordinate;
}

CardinalDirection _parseOrientation(String maybeOrientation) {
  final direction = CardinalDirection.symbolMap[maybeOrientation];
  if (direction == null) {
    throw UserInputException('Unknown direction: $maybeOrientation');
  }

  return direction;
}

List<LanderInstruction> _parseInstructions(String maybeInstructions) {
  final instructions = maybeInstructions.split('').map((maybeInstruction) {
    final instruction = LanderInstruction.instructionMap[maybeInstruction];
    if (instruction == null) {
      throw UserInputException('Unknown instruction: $maybeInstruction');
    }

    return instruction;
  });

  return List.unmodifiable(instructions);
}
