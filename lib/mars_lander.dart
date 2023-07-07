import 'package:mars_lander/mars_surface.dart';
import 'package:mars_lander/navigation/lander_mission.dart';
import 'package:mars_lander/traverse_result.dart';

void runMission({
  required int marsX,
  required int marsY,
  required List<LanderMission> missions,
}) {
  final mars = MarsSurface(x: marsX, y: marsY);
  for (final mission in missions) {
    final result = mars.traverse(mission.startingPoint, mission.instructions);
    print(_formatResult(result));
  }
}

String _formatResult(TraverseResult result) {
  return '${result.location.x} ${result.location.y} ${result.location.orientation.symbol}'
      '${!result.success ? ' LOST' : ''}';
}
