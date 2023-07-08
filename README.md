## Installation and running

Install Dart 3 for your operating system, using instructions provided in the
[official documentation](https://dart.dev/get-dart).

Run application with `dart run` command in the repository root. Application takes
data directly from STDIN, first line must be _size_ of Mars give as two integers
separated by a space. Next two lines are the Mars Lander location and instructions.
First provide its starting point and orientation as two integers (X and Y
coordinates), followed up by cardinal direction for orientation (one of "N", "E",
"S", "W"). Next line is a string of lander instructions "L" or "R" for turning
left or right and "F" for moving forward. Confirm entered data by pressing enter.
Add more landers by repeating above steps. To finish and run simulations press
_enter_ twice after last lander configuration.

Example input and output can be found in `test/mars_lander_test.dart`.

## Testing

Run all tests with `dart test` command.
