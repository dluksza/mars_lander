import 'package:mars_lander/lander_navigation.dart';
import 'package:mars_lander/navigation/lander_instruction.dart';
import 'package:mars_lander/navigation/lander_location.dart';
import 'package:mars_lander/traverse_result.dart';

class MarsSurface {
  final int x;
  final int y;

  final _navigator = LanderNavigation();
  final _lostLanders = <LanderLocation>{};

  MarsSurface({required this.x, required this.y});

  TraverseResult traverse(
    LanderLocation startingPoint,
    List<LanderInstruction> instructions,
  ) {
    var location = startingPoint;
    for (final instruction in instructions) {
      final nextLocation = _navigator.move(location, instruction);
      if (_lostLanders.contains(nextLocation)) {
        continue;
      }

      if (_isNotValidLocation(nextLocation)) {
        _lostLanders.add(nextLocation);
        return TraverseResult.failure(location);
      }

      location = nextLocation;
    }

    return TraverseResult.success(location);
  }

  bool _isNotValidLocation(LanderLocation location) {
    return switch (location) {
      LanderLocation(x: final x) when x < 0 || x > this.x => true,
      LanderLocation(y: final y) when y < 0 || y > this.y => true,
      _ => false,
    };
  }
}
