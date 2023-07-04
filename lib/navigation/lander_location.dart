import 'package:mars_lander/navigation/cardinal_direction.dart';

class LanderLocation {
  final int x;
  final int y;
  final CardinalDirection orientation;

  const LanderLocation({
    required this.x,
    required this.y,
    required this.orientation,
  });

  LanderLocation copyWith({int? x, int? y, CardinalDirection? orientation}) {
    return LanderLocation(
      x: x ?? this.x,
      y: y ?? this.y,
      orientation: orientation ?? this.orientation,
    );
  }

  @override
  String toString() {
    return "LanderLocation(x: $x, y: $y, orientation: ${orientation.name})";
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is LanderLocation &&
            (other.x == x && other.y == y && other.orientation == orientation);
  }

  @override
  int get hashCode {
    return Object.hash(x, y, orientation);
  }
}
