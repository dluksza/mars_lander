import 'package:mars_lander/navigation/cardinal_direction.dart';
import 'package:mars_lander/navigation/lander_instruction.dart';
import 'package:mars_lander/navigation/lander_location.dart';

class LanderNavigation {
  LanderLocation move(LanderLocation location, LanderInstruction instruction) {
    return switch (instruction) {
      LanderInstruction.left => _moveLeft(location),
      LanderInstruction.rigth => _moveRight(location),
      LanderInstruction.forward => _moveForward(location),
    };
  }

  LanderLocation _moveLeft(LanderLocation location) {
    final newOrientation = switch (location.orientation) {
      CardinalDirection.north => CardinalDirection.west,
      CardinalDirection.east => CardinalDirection.north,
      CardinalDirection.south => CardinalDirection.east,
      CardinalDirection.west => CardinalDirection.south,
    };

    return location.copyWith(orientation: newOrientation);
  }

  LanderLocation _moveRight(LanderLocation location) {
    final newOrientation = switch (location.orientation) {
      CardinalDirection.north => CardinalDirection.east,
      CardinalDirection.east => CardinalDirection.south,
      CardinalDirection.south => CardinalDirection.west,
      CardinalDirection.west => CardinalDirection.north,
    };

    return location.copyWith(orientation: newOrientation);
  }

  LanderLocation _moveForward(LanderLocation location) {
    return switch (location) {
      LanderLocation(y: final y, orientation: CardinalDirection.north) =>
        location.copyWith(y: y + 1),
      LanderLocation(x: final x, orientation: CardinalDirection.east) =>
        location.copyWith(x: x + 1),
      LanderLocation(y: final y, orientation: CardinalDirection.south) =>
        location.copyWith(y: y - 1),
      LanderLocation(x: final x, orientation: CardinalDirection.west) =>
        location.copyWith(x: x - 1),
    };
  }
}
