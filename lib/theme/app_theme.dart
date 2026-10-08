import 'package:flutter/material.dart';

class AppColors {
  static const forest = Color(0xFF234F3D);
  static const sage = Color(0xFF78927A);
  static const terracotta = Color(0xFFD9826B);
  static const peach = Color(0xFFF1C4B5);
  static const cream = Color(0xFFFAF6EF);
  static const white = Color(0xFFFFFFFF);
  static const charcoal = Color(0xFF26312C);
  static const muted = Color(0xFF7A7A70);
}

class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.cream,

    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.forest,
      primary: AppColors.forest,
      secondary: AppColors.terracotta,
      surface: AppColors.cream,
    ),

    fontFamily: 'sans',

    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: AppColors.forest,
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: TextStyle(
        color: AppColors.forest,
        fontWeight: FontWeight.w700,
      ),
      bodyLarge: TextStyle(
        color: AppColors.charcoal,
      ),
      bodyMedium: TextStyle(
        color: AppColors.muted,
      ),
    ),
  );
}