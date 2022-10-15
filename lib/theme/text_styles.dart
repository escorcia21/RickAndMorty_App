import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static String? get fontFamily => GoogleFonts.dmSans().fontFamily;

  // Google font
  static TextStyle get defaultFontStyle => GoogleFonts.dmSans();

  // if we need to change a style

  // Headline 1
  static TextStyle get headline1 => GoogleFonts.dmSans(
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      );
  // Headline 2
  static TextStyle get headline2 => GoogleFonts.dmSans(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      );
  // Headline 3
  static TextStyle get headline3 => GoogleFonts.dmSans(
        fontSize: 14.0,
        fontWeight: FontWeight.w700,
      );

  // headline 4
  static TextStyle get headline4 => GoogleFonts.dmSans(
        fontSize: 12.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      );

  // Bodytext 1
  static TextStyle get bodytext1 => GoogleFonts.roboto(
        fontSize: 16.0,
      );
  // Caption
  static TextStyle get caption => GoogleFonts.dmSans(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      );

  // subtitle 1
  static TextStyle get subtitle1 => GoogleFonts.dmSans(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
      );

  // subtitle 2
  static TextStyle get subtitle2 => GoogleFonts.dmSans(
        fontSize: 12.0,
      );

  static TextTheme get textTheme => TextTheme(
        displayLarge: headline1,
        displayMedium: headline2,
        displaySmall: headline3,
        headlineMedium: headline4,
        bodyLarge: bodytext1,
        bodySmall: caption,
        titleMedium: subtitle1,
        titleSmall: subtitle2,
      );
}
