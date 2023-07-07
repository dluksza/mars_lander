import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';

void main() {
  test('main app', () async {
    final input = '''
5 3
1 1 E
RFRFRFRF

3 2 N
FRRFLLFFRRFLL

0 3 W
LLFFFLFLFL


''';

    final expectedOutput = '''
1 1 E
3 3 N LOST
2 3 S
''';

    final process = await Process.start('dart', ['bin/mars_lander.dart']);

    for (final line in input.split('\n')) {
      process.stdin.writeln(line);
    }

    final actualOutput = await process.stdout.transform(Utf8Decoder()).join();

    expect(actualOutput, expectedOutput);
  });
}
