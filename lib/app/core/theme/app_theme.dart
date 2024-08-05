import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purple_planet_packaging/app/core/utils/app_colors.dart';
import 'package:purple_planet_packaging/app/core/utils/app_styles.dart';

class AppTheme {
  /// for getting light theme
  ThemeData get lightTheme {
    // TODO: add light theme here
    return ThemeData(
      fontFamily: GoogleFonts.montserrat().fontFamily,
      scaffoldBackgroundColor: AppColors.scaffoldBackground,
      colorScheme: ColorScheme.fromSwatch(primarySwatch: AppColors.primaryMaterial),
      inputDecorationTheme: inputDecorationTheme,
      elevatedButtonTheme: elevatedButtonTheme,
      appBarTheme: appBarTheme,
    );
  }

  /// for getting dark theme
  ThemeData get darkTheme {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.scaffoldBackground,
      colorScheme: ColorScheme.fromSwatch(primarySwatch: AppColors.primaryMaterial),
      inputDecorationTheme: inputDecorationTheme,
      elevatedButtonTheme: elevatedButtonTheme,
      appBarTheme: appBarTheme,
    );
  }

  final AppBarTheme appBarTheme = AppBarTheme(
    backgroundColor: AppColors.scaffoldBackground,
    elevation: 0,
    titleTextStyle: AppStyles.largeStyle(color: AppColors.primaryColor),
    surfaceTintColor: Colors.transparent,
  );

  final InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    alignLabelWithHint: true,
    fillColor: AppColors.white,
    // filled: true,
    // floatingLabelBehavior: FloatingLabelBehavior.auto,
    hintStyle: AppStyles.hintStyle(),
    labelStyle: AppStyles.mediumStyle(),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.red)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.primaryColor)),
    contentPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 1.0),
    prefixStyle: AppStyles.lightStyle(),
  );

  final ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
      textStyle: WidgetStateProperty.all(AppStyles.mediumBoldStyle(color: Colors.white)),
      backgroundColor: WidgetStateProperty.all(AppColors.primaryColor),
      maximumSize: WidgetStateProperty.all(const Size(double.infinity, 60)),
      minimumSize: WidgetStateProperty.all(const Size(double.infinity, 50)),
      shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      foregroundColor: WidgetStateProperty.all(AppColors.white),
    ),
  );
}

/// for providing app theme [AppTheme]
final appThemeProvider = Provider<AppTheme>((_) => AppTheme());
