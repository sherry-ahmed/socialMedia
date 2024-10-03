import 'package:flutter/material.dart';
import 'package:socialmedia/gen/fonts.gen.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      scaffoldBackgroundColor: Colors.black,
      iconTheme: const IconThemeData(color: Colors.white),
      appBarTheme: const AppBarTheme(
        color: Colors.black,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          fontSize: 22,
          fontFamily: FontFamily.sFProDisplayMedium,
          color: Colors.white,
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w500,
          fontFamily: FontFamily.sFProDisplayMedium,
          height: 1.6,
        ),
        headlineMedium: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w500,
          fontFamily: FontFamily.sFProDisplayMedium,
          height: 1.6,
        ),
        headlineSmall: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          fontFamily: FontFamily.sFProDisplayBold,
          height: 1.5,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          decoration: TextDecoration.underline,
          decorationColor: Colors.white,
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontFamily: FontFamily.sFProDisplayBold,
          height: 1.6,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontFamily: FontFamily.sFProDisplayBold,
          height: 1.5,
        ),
        titleSmall: TextStyle(
          fontSize: 16,
          color: Colors.black38,
          fontWeight: FontWeight.bold,
          fontFamily: FontFamily.sFProDisplayLight,
          height: 1.5,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontFamily: FontFamily.sFProDisplayMedium,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          fontSize: 12,
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontFamily: FontFamily.sFProDisplayBold,
          height: 1.6,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontFamily: FontFamily.sFProDisplayBold,
          height: 1.6,
        ),
        labelLarge: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          fontFamily: FontFamily.sFProDisplayBold,
          height: 2.26,
        ),
      ),
      useMaterial3: true,
    );
  }
}
