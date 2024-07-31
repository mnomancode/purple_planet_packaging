import 'package:flutter/material.dart';

class AppUtils {
  AppUtils._();

  static isTablet(BuildContext context) {
    final data = MediaQuery.of(context);
    return data.size.shortestSide > 600;
  }
}
