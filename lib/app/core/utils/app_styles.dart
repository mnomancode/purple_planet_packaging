import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppStyles {
  // write instance code

  static EdgeInsetsGeometry scaffoldPadding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0);

  static TextStyle hintStyle({Color? color, double fontSize = 12.0}) {
    return GoogleFonts.montserrat(color: color ?? Colors.grey, fontSize: fontSize.sp);
  }

  static TextStyle lightStyle({Color? color, double fontSize = 12.0}) {
    return GoogleFonts.montserrat(color: color, fontSize: fontSize.sp);
  }

  static TextStyle mediumStyle(
      {Color? color, double fontSize = 14.0, double? letterSpacing, double? height, FontWeight? fontWeight}) {
    return GoogleFonts.montserrat(
      color: color,
      fontSize: fontSize.sp,
      fontWeight: fontWeight ?? FontWeight.w400,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  static TextStyle mediumBoldStyle({Color? color, double fontSize = 14.0}) {
    return GoogleFonts.montserrat(color: color, fontSize: fontSize.sp, fontWeight: FontWeight.w500);
  }

  static TextStyle boldStyle({Color? color, double fontSize = 15.0, FontWeight? fontWeight, double? height}) {
    return GoogleFonts.montserrat(
      color: color,
      fontSize: fontSize.sp,
      fontWeight: fontWeight ?? FontWeight.w600,
      height: height,
    );
  }

  static TextStyle largeStyle({
    Color color = Colors.black,
    double fontSize = 18.0,
    FontWeight fontWeight = FontWeight.bold,
  }) {
    return GoogleFonts.montserrat(
      color: color,
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
    );
  }

  static final ButtonStyle buttonStyle = ButtonStyle(
    textStyle: WidgetStateProperty.all(AppStyles.mediumStyle(color: Colors.white)),
    backgroundColor: WidgetStateProperty.all(AppColors.primaryColor),
    maximumSize: WidgetStateProperty.all(const Size(double.infinity, 60)),
    minimumSize: WidgetStateProperty.all(const Size(double.infinity, 52)),
    shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
    foregroundColor: WidgetStateProperty.all(AppColors.white),
  );
}