extension StringExtension on String {
  String addTwentyPercent() {
    // Convert the string to a double
    double? value = double.tryParse(this);
    if (value != null) {
      // Add 20% to the value
      double increasedValue = value * 1.20;
      // Convert the new value back to a string and return it
      return increasedValue.toStringAsFixed(2);
      // return increasedValue.toString();
    } else {
      // Return null if the conversion fails
      return '';
    }
  }

  String? addDecimalFromEnd(int? indexFromEnd) {
    if (indexFromEnd == null) {
      return this;
    }
    // Ensure the index is within the valid range
    if (indexFromEnd < 0 || indexFromEnd > length) {
      return null; // Return null if the index is out of range
    }

    // Calculate the position to insert the decimal point
    int insertPosition = length - indexFromEnd;

    // Insert the decimal point at the specified position
    String updatedString = '${substring(0, insertPosition)}.${substring(insertPosition)}';

    return updatedString;
  }

  String addShippingCharge(double? charge) {
    // Convert the string to a double
    double? value = double.tryParse(this);
    if (value != null) {
      double increasedValue = value + (charge ?? 0.0);
      // Convert the new value back to a string and return it
      return increasedValue.toStringAsFixed(2);
      // return increasedValue.toString();
    } else {
      // Return null if the conversion fails
      return '';
    }
  }
}
