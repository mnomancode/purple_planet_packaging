import 'dart:math';

extension RoundDouble on double {
  double roundToPlaces(int places) {
    num mod = pow(10.0, places);
    return ((this * mod).round().toDouble() / mod);
  }

  double addShippingCharge(double charge) {
    // Convert the string to a double
    double? value = this;
    double increasedValue = value + charge;
    // Convert the new value back to a string and return it
    return increasedValue;
    // return increasedValue.toString();
  }
}
