import 'package:test/test.dart';
import 'package:mars_lander/lander_navigation.dart';
import 'package:mars_lander/navigation/cardinal_direction.dart';
import 'package:mars_lander/navigation/lander_instruction.dart';
import 'package:mars_lander/navigation/lander_location.dart';

void main() {
  final navigator = LanderNavigation();
  const location =
      LanderLocation(x: 81, y: 64, orientation: CardinalDirection.south);
  testSideMove(LanderInstruction instruction) => ({
        required CardinalDirection actualDirection,
        required CardinalDirection expectedDirection,
      }) =>
          test(actualDirection.name, () {
            final actual = navigator.move(
              location.copyWith(orientation: actualDirection),
              instruction,
            );

            expect(actual.x, location.x);
            expect(actual.y, location.y);
            expect(actual.orientation, expectedDirection);
          });

  group('move left', () {
    final testLeftMove = testSideMove(LanderInstruction.left);

    testLeftMove(
      actualDirection: CardinalDirection.north,
      expectedDirection: CardinalDirection.west,
    );

    testLeftMove(
      actualDirection: CardinalDirection.east,
      expectedDirection: CardinalDirection.north,
    );

    testLeftMove(
      actualDirection: CardinalDirection.south,
      expectedDirection: CardinalDirection.east,
    );

    testLeftMove(
      actualDirection: CardinalDirection.west,
      expectedDirection: CardinalDirection.south,
    );
  });

  group('move right', () {
    final testRightMove = testSideMove(LanderInstruction.right);

    testRightMove(
      actualDirection: CardinalDirection.north,
      expectedDirection: CardinalDirection.east,
    );

    testRightMove(
      actualDirection: CardinalDirection.east,
      expectedDirection: CardinalDirection.south,
    );

    testRightMove(
      actualDirection: CardinalDirection.south,
      expectedDirection: CardinalDirection.west,
    );

    testRightMove(
      actualDirection: CardinalDirection.west,
      expectedDirection: CardinalDirection.north,
    );
  });

  group('move forward', () {
    test('north', () {
      final actual = navigator.move(
        location.copyWith(orientation: CardinalDirection.north),
        LanderInstruction.forward,
      );

      expect(actual.x, location.x);
      expect(actual.y, location.y + 1);
      expect(actual.orientation, CardinalDirection.north);
    });

    test('east', () {
      final actual = navigator.move(
        location.copyWith(orientation: CardinalDirection.east),
        LanderInstruction.forward,
      );

      expect(actual.x, location.x + 1);
      expect(actual.y, location.y);
      expect(actual.orientation, CardinalDirection.east);
    });

    test('south', () {
      final actual = navigator.move(
        location.copyWith(orientation: CardinalDirection.south),
        LanderInstruction.forward,
      );

      expect(actual.x, location.x);
      expect(actual.y, location.y - 1);
      expect(actual.orientation, CardinalDirection.south);
    });

    test('west', () {
      final actual = navigator.move(
        location.copyWith(orientation: CardinalDirection.west),
        LanderInstruction.forward,
      );

      expect(actual.x, location.x - 1);
      expect(actual.y, location.y);
      expect(actual.orientation, CardinalDirection.west);
    });
  });
}
