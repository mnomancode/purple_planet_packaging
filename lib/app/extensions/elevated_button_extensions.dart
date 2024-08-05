// alterP [Change properties of ElevatedButton]
import 'package:flutter/material.dart';

import '../core/utils/app_colors.dart';

extension ElevatedButtonExtension on ElevatedButton {
  ElevatedButton alterP({Color color = AppColors.primaryColor, bool isTransparent = false, bool isSmall = false}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        overlayColor: isTransparent
            ? WidgetStateProperty.all<Color>(Colors.transparent)
            : WidgetStateProperty.all<Color>(AppColors.primaryColor),
        maximumSize: WidgetStateProperty.all<Size>(Size(isSmall ? 200 : double.infinity, 60.0)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: isTransparent ? AppColors.primaryColor : color, width: 2.0)),
        ),
        minimumSize: WidgetStateProperty.all<Size>(Size(isSmall ? 200 : double.infinity, 50.0)),
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.symmetric(vertical: 8.0)),
        backgroundColor:
            isTransparent ? WidgetStateProperty.all<Color>(Colors.transparent) : WidgetStateProperty.all<Color>(color),
        elevation: WidgetStateProperty.all<double>(isTransparent ? 0 : 1.0),
        foregroundColor: isTransparent
            ? WidgetStateProperty.all<Color>(AppColors.primaryColor)
            : WidgetStateProperty.all<Color>(AppColors.white),
        shadowColor:
            isTransparent ? WidgetStateProperty.all<Color>(Colors.transparent) : WidgetStateProperty.all<Color>(color),
      ),
      child: child,
    );
  }
}
