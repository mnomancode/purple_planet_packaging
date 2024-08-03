import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppStyles {
  // write instance code

  static EdgeInsetsGeometry scaffoldPadding = const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0);

  static TextStyle hintStyle({Color? color, double fontSize = 13.0}) {
    return GoogleFonts.montserrat(color: color ?? Colors.grey, fontSize: fontSize.sp);
  }

  static TextStyle lightStyle({Color? color, double fontSize = 12.0}) {
    return GoogleFonts.montserrat(color: color, fontSize: fontSize.sp);
  }

  static TextStyle mediumStyle({Color? color, double fontSize = 16.0}) {
    return GoogleFonts.montserrat(color: color, fontSize: fontSize.sp, fontWeight: FontWeight.w400);
  }

  static TextStyle mediumBoldStyle({Color? color, double fontSize = 16.0}) {
    return GoogleFonts.montserrat(color: color, fontSize: fontSize.sp, fontWeight: FontWeight.bold);
  }

  static TextStyle boldStyle({Color? color, double fontSize = 16.0, FontWeight? fontWeight}) {
    return GoogleFonts.montserrat(color: color, fontSize: fontSize.sp, fontWeight: fontWeight ?? FontWeight.w600);
  }

  static TextStyle largeStyle({
    Color color = Colors.black,
    double fontSize = 20.0,
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
