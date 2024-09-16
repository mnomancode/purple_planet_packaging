import 'dart:math';

extension RoundDouble on double {
  double roundToPlaces(int places) {
    num mod = pow(10.0, places);
    return ((this * mod).round().toDouble() / mod);
  }
}
