import 'package:test/test.dart';
import 'package:mars_lander/mars_surface.dart';
import 'package:mars_lander/navigation/cardinal_direction.dart';
import 'package:mars_lander/navigation/lander_instruction.dart';
import 'package:mars_lander/navigation/lander_location.dart';

void main() {
  group('traverse', () {
    const startingPoint =
        LanderLocation(x: 0, y: 0, orientation: CardinalDirection.north);

    test('round trip', () {
      final surface = MarsSurface(x: 1, y: 1);

      final actual = surface.traverse(
        startingPoint,
        [
          LanderInstruction.forward,
          LanderInstruction.right,
          LanderInstruction.forward,
          LanderInstruction.right,
          LanderInstruction.forward,
          LanderInstruction.right,
          LanderInstruction.forward,
        ],
      );

      expect(actual.success, isTrue);
      expect(
        actual.location,
        const LanderLocation(x: 0, y: 0, orientation: CardinalDirection.west),
      );
    });

    test('lander lost', () {
      final surface = MarsSurface(x: 1, y: 1);

      final actual = surface.traverse(
        startingPoint,
        [LanderInstruction.forward, LanderInstruction.forward],
      );

      expect(actual.success, isFalse);
      expect(
        actual.location,
        const LanderLocation(x: 0, y: 1, orientation: CardinalDirection.north),
      );
    });

    test('remember lost lander location', () {
      final surface = MarsSurface(x: 1, y: 1);

      final _lostLander = surface.traverse(
        startingPoint,
        [
          LanderInstruction.forward,
          LanderInstruction.forward,
        ],
      );
      final actual = surface.traverse(startingPoint, [
        LanderInstruction.forward,
        LanderInstruction.forward,
        LanderInstruction.right,
      ]);

      expect(actual.success, isTrue);
      expect(
        actual.location,
        const LanderLocation(x: 0, y: 1, orientation: CardinalDirection.east),
      );
    });
  });

  test('test data', () {
    final surface = MarsSurface(x: 5, y: 3);
    const firstLanderLocation =
        LanderLocation(x: 1, y: 1, orientation: CardinalDirection.east);
    final firstLanderInstructions = [
      LanderInstruction.right,
      LanderInstruction.forward,
      LanderInstruction.right,
      LanderInstruction.forward,
      LanderInstruction.right,
      LanderInstruction.forward,
      LanderInstruction.right,
      LanderInstruction.forward,
    ];
    const secondLanderLocation =
        LanderLocation(x: 3, y: 2, orientation: CardinalDirection.north);
    // FRRFLLFFRRFLL
    final secondLanderInstrucions = [
      LanderInstruction.forward,
      LanderInstruction.right,
      LanderInstruction.right,
      LanderInstruction.forward,
      LanderInstruction.left,
      LanderInstruction.left,
      LanderInstruction.forward,
      LanderInstruction.forward,
      LanderInstruction.right,
      LanderInstruction.right,
      LanderInstruction.forward,
      LanderInstruction.left,
      LanderInstruction.left,
    ];
    const thirdLanderLocation =
        LanderLocation(x: 0, y: 3, orientation: CardinalDirection.west);
    const thirdLanderInstructions = [
      LanderInstruction.left,
      LanderInstruction.left,
      LanderInstruction.forward,
      LanderInstruction.forward,
      LanderInstruction.forward,
      LanderInstruction.left,
      LanderInstruction.forward,
      LanderInstruction.left,
      LanderInstruction.forward,
      LanderInstruction.left,
    ];

    final firstFinish =
        surface.traverse(firstLanderLocation, firstLanderInstructions);
    final secondFinish =
        surface.traverse(secondLanderLocation, secondLanderInstrucions);
    final thirdFinish =
        surface.traverse(thirdLanderLocation, thirdLanderInstructions);

    expect(firstFinish.success, isTrue);
    expect(
      firstFinish.location,
      const LanderLocation(x: 1, y: 1, orientation: CardinalDirection.east),
    );

    expect(secondFinish.success, false);
    expect(
      secondFinish.location,
      const LanderLocation(x: 3, y: 3, orientation: CardinalDirection.north),
    );

    expect(thirdFinish.success, true);
    expect(
      thirdFinish.location,
      const LanderLocation(x: 2, y: 3, orientation: CardinalDirection.south),
    );
  });
}
