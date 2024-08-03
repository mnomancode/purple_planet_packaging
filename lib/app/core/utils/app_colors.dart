import 'package:flutter/material.dart';

class AppColors {
  static const Color white = Colors.white;

  static const Color scaffoldBackground = Color(0xFFF5F5F5);

  static const Color greyColor = Colors.grey;
  static const Color lightGreyColor = Color(0xFFEEEEEE);

  static const Color blackColor = Colors.black;

  static const Color darkGrey = Color(0xFF333333);

  AppColors._();

  static const Color primaryColor = Color(0xFF4F266B);
  static const Color secondaryColor = Color(0xFF108035);
  static const Color lightPurple = Color(0xFF951B81);
  static const Color lightGreen = Color(0xFF8FC03C);

  static const Color lightPrimaryColor = Color(0x184F266B);

  static const MaterialColor primaryMaterial = MaterialColor(_palettePrimaryValue, <int, Color>{
    50: Color(0xFFEAE5ED),
    100: Color(0xFFCABED3),
    200: Color(0xFFA793B5),
    300: Color(0xFF846797),
    400: Color(0xFF694781),
    500: Color(_palettePrimaryValue),
    600: Color(0xFF482263),
    700: Color(0xFF3F1C58),
    800: Color(0xFF36174E),
    900: Color(0xFF260D3C),
  });
  static const int _palettePrimaryValue = 0xFF4F266B;

  static const MaterialColor palette0Accent = MaterialColor(_paletteAccentValue, <int, Color>{
    100: Color(0xFFB976FF),
    200: Color(_paletteAccentValue),
    400: Color(0xFF8410FF),
    700: Color(0xFF7800F6),
  });
  static const int _paletteAccentValue = 0xFF9F43FF;
}
