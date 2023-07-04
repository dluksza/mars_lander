import 'package:test/test.dart';
import 'package:mars_lander/navigation/cardinal_direction.dart';
import 'package:mars_lander/navigation/lander_location.dart';

void main() {
  const orig =
      LanderLocation(x: 11, y: 21, orientation: CardinalDirection.south);
  group("copyWith", () {
    test("x", () {
      final actual = orig.copyWith(x: 89);

      expect(actual.x, 89);
      expect(actual.y, 21);
      expect(actual.orientation, CardinalDirection.south);
    });

    test("y", () {
      final actual = orig.copyWith(y: -1);

      expect(actual.x, 11);
      expect(actual.y, -1);
      expect(actual.orientation, CardinalDirection.south);
    });

    test("orientation", () {
      final actual = orig.copyWith(orientation: CardinalDirection.north);

      expect(actual.x, 11);
      expect(actual.y, 21);
      expect(actual.orientation, CardinalDirection.north);
    });
  });

  test('equals', () {
    expect(orig == orig, isTrue);
    expect(
      orig ==
          const LanderLocation(
              x: 11, y: 21, orientation: CardinalDirection.south),
      isTrue,
    );

    expect(orig == orig.copyWith(x: 0), isFalse);
    expect(orig == orig.copyWith(y: 0), isFalse);
    expect(orig == orig.copyWith(orientation: CardinalDirection.east), isFalse);
  });
}
