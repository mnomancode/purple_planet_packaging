// write a extension method for the BuildContext class to get the size of the screen.
// The method should return context.isTablet will return true if the screen size is greater than 600.

import 'package:flutter/widgets.dart';

extension ContextExtension on BuildContext {
  bool get isTablet => MediaQuery.of(this).size.width >= 600;
}
