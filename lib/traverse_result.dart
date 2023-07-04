import 'package:mars_lander/navigation/lander_location.dart';

class TraverseResult {
  final bool success;
  final LanderLocation location;

  const TraverseResult.success(this.location) : success = true;

  const TraverseResult.failure(this.location) : success = false;
}
