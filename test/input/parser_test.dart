import 'package:mars_lander/input/parser.dart';
import 'package:mars_lander/navigation/cardinal_direction.dart';
import 'package:mars_lander/navigation/lander_instruction.dart';
import 'package:mars_lander/navigation/lander_location.dart';
import 'package:test/test.dart';

void main() {
  group('parseMarsSize', () {
    test('parse correct data', () {
      expect(parseMarsSize("8 9"), (8, 9));
    });

    test('fail on non-integer data', () {
      expect(
        () => parseMarsSize("1 a"),
        throwsUserInputError('Cannot parse "a"'),
      );
      expect(
        () => parseMarsSize("8 p"),
        throwsUserInputError('Cannot parse "p"'),
      );
    });

    test('fail on negative coordinates', () {
      expect(
        () => parseMarsSize("-8 9"),
        throwsUserInputError('Coordinate cannot be negative number'),
      );
      expect(
        () => parseMarsSize("9 -1"),
        throwsUserInputError('Coordinate cannot be negative number'),
      );
    });

    test('fail on 0 coordinate', () {
      expect(
        () => parseMarsSize("0 15"),
        throwsUserInputError('Mars size cannot be negative'),
      );
      expect(
        () => parseMarsSize("5 0"),
        throwsUserInputError('Mars size cannot be negative'),
      );
    });

    test('fail on too big coordinate', () {
      expect(
        () => parseMarsSize("4 1", maxValue: 3),
        throwsUserInputError('Value 4 is greater than maximum allowed of 3'),
      );
      expect(
        () => parseMarsSize("1 4", maxValue: 3),
        throwsUserInputError('Value 4 is greater than maximum allowed of 3'),
      );
    });

    test('fail on a single coordinate', () {
      expect(
        () => parseMarsSize("53"),
        throwsUserInputError('Invalid format of Mars size input'),
      );
    });
  });

  group('parseLanderStartPosition', () {
    test('parse correct data', () {
      expect(
        parseLanderStartPosition("1 5 S"),
        LanderLocation(x: 1, y: 5, orientation: CardinalDirection.south),
      );
      expect(
        parseLanderStartPosition("0 0 W"),
        LanderLocation(x: 0, y: 0, orientation: CardinalDirection.west),
      );
    });

    test('fail on negative coordinate', () {
      expect(
        () => parseLanderStartPosition("-1 0 N"),
        throwsUserInputError('Coordinate cannot be negative number'),
      );
      expect(
        () => parseLanderStartPosition("0 -1 N"),
        throwsUserInputError('Coordinate cannot be negative number'),
      );
    });

    test('fail on too big coordinate', () {
      expect(
        () => parseLanderStartPosition("3 1 S", maxValue: 2),
        throwsUserInputError('Value 3 is greater than maximum allowed of 2'),
      );
      expect(
        () => parseLanderStartPosition("1 3 S", maxValue: 2),
        throwsUserInputError('Value 3 is greater than maximum allowed of 2'),
      );
    });

    test('fail on invalid cardinal direction', () {
      expect(
        () => parseLanderStartPosition("1 1 D"),
        throwsUserInputError('Unknown direction: D'),
      );
    });

    test('fail on invalid input', () {
      expect(
        () => parseLanderStartPosition("1 1"),
        throwsUserInputError('Invalid format of lander initial location'),
      );
      expect(() => parseLanderStartPosition("asdf"),
          throwsUserInputError('Invalid format of lander initial location'));
    });
  });

  group('parseLanderInstructions', () {
    test('parse correct data', () {
      expect(
        parseLanderInstructions("LRF"),
        [
          LanderInstruction.left,
          LanderInstruction.right,
          LanderInstruction.forward
        ],
      );
    });

    test('handle empty input', () {
      expect(parseLanderInstructions(""), []);
    });

    test('fails on invalid instruction', () {
      expect(
        () => parseLanderInstructions('LU'),
        throwsUserInputError('Unknown instruction: U'),
      );
    });

    test('fails on invalid input', () {
      expect(
        () => parseLanderInstructions('aaa'),
        throwsUserInputError('Unknown instruction: a'),
      );
    });

    test('fails on too many instructions', () {
      expect(
        () => parseLanderInstructions('FFL', maxInstructions: 2),
        throwsUserInputError(
            'Mars lander can only take 2 instructions, but 3 was given'),
      );
    });
  });
}

Matcher throwsUserInputError([String message = '']) => throwsA(
      allOf(
        TypeMatcher<UserInputException>(),
        predicate(
          (e) => (e as UserInputException).message == message,
          'exception message match',
        ),
      ),
    );
