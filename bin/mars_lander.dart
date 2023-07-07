import 'dart:io';

import 'package:mars_lander/input/parser.dart';
import 'package:mars_lander/mars_lander.dart';
import 'package:mars_lander/navigation/lander_mission.dart';

void main(List<String> arguments) {
  try {
    final (x, y) = parseMarsSize(stdin.readLineSync()!);
    final landerMissions = _readMissions();

    runMission(marsX: x, marsY: y, missions: landerMissions);
  } on UserInputException catch (e) {
    print(e.message);
    exit(1);
  }
}

List<LanderMission> _readMissions() {
  final landerMissions = <LanderMission>[];
  do {
    final landerPostionInput = stdin.readLineSync();
    if (landerPostionInput == null || landerPostionInput.isEmpty) {
      break;
    }

    final startingPosition = parseLanderStartPosition(landerPostionInput);
    final instructions = parseLanderInstructions(stdin.readLineSync()!);
    landerMissions.add(LanderMission(startingPosition, instructions));
    stdin.readLineSync();
  } while (true);

  return landerMissions;
}
