import 'package:mars_lander/navigation/lander_instruction.dart';
import 'package:mars_lander/navigation/lander_location.dart';

class LanderMission {
  final LanderLocation startingPoint;
  final List<LanderInstruction> instructions;

  const LanderMission(this.startingPoint, this.instructions);
}
