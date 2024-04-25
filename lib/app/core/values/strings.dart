

import 'dart:ui';
import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppStyle {
  AppStyle._();

  static TextStyle light({
    Color? color,
    double? fontSize,
    TextDecoration? decoration,
    FontStyle? fontStyle,
  }) {
    return GoogleFonts.inter(
      color: color ?? AppColors.text,
      fontSize: fontSize ?? 16,
      fontWeight: FontWeight.w200,
      decoration: decoration,
      fontStyle: fontStyle,
    );
  }

  static TextStyle regular({
    Color? color,
    double? fontSize,
    TextDecoration? decoration,
    FontStyle? fontStyle,
  }) {
    return GoogleFonts.inter(
      color: color ?? AppColors.text,
      fontSize: fontSize ?? 16,
      fontWeight: FontWeight.w400,
      decoration: decoration,
      fontStyle: fontStyle,
    );
  }

  static TextStyle medium({
    Color? color,
    double? fontSize,
    TextDecoration? decoration,
    FontStyle? fontStyle,
  }) {
    return GoogleFonts.inter(
      color: color ?? AppColors.text,
      fontSize: fontSize ?? 16,
      fontWeight: FontWeight.w500,
      decoration: decoration,
      fontStyle: fontStyle,
    );
  }

  static TextStyle semiBold({
    Color? color,
    double? fontSize,
    TextDecoration? decoration,
    FontStyle? fontStyle,
  }) {
    return GoogleFonts.inter(
      color: color ?? AppColors.text,
      fontSize: fontSize ?? 16,
      fontWeight: FontWeight.w600,
      decoration: decoration,
      fontStyle: fontStyle,
    );
  }

  static TextStyle bold({
    Color? color,
    double? fontSize,
    TextDecoration? decoration,
    FontStyle? fontStyle,
  }) {
    return GoogleFonts.inter(
      color: color ?? AppColors.text,
      fontSize: fontSize ?? 16,
      fontWeight: FontWeight.w700,
      decoration: decoration,
      fontStyle: fontStyle,
    );
  }
}
