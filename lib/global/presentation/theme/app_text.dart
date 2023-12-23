import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextTheme {
  const AppTextTheme._();
  static final theme = TextTheme(
    headlineLarge: AppTextStyle.headlineLarge,
    headlineMedium: AppTextStyle.headlineMedium,
    headlineSmall: AppTextStyle.headlineSmall,
    titleLarge: AppTextStyle.titleLarge,
    titleMedium: AppTextStyle.titleMedium,
    titleSmall: AppTextStyle.titleSmall,
    bodyLarge: AppTextStyle.bodyLarge,
    bodyMedium: AppTextStyle.bodyMedium,
    bodySmall: AppTextStyle.bodySmall,
    labelMedium: AppTextStyle.labelMedium,
    labelSmall: AppTextStyle.labelSmall,
  );
}

class AppTextStyle {
  const AppTextStyle._();
  
  static final headlineLarge = TextStyle(fontSize: 34, letterSpacing: percentToPx(0.07), height: 1.18);
  static final headlineMedium = TextStyle(fontSize: 28, letterSpacing: percentToPx(-0.45), height: 1.14);
  static final headlineSmall = TextStyle(fontSize: 22, letterSpacing: percentToPx(-0.26), height: 1.27);
  static final titleLarge = TextStyle(fontSize: 20, letterSpacing: percentToPx(-0.44), height: 1.20);
  static final titleMedium = TextStyle(fontSize: 16, letterSpacing: percentToPx(-2.31), height: 1.25);
  static final titleSmall = TextStyle(fontSize: 15, letterSpacing: percentToPx(-0.23), height: 1.33);
  static final bodyLarge = TextStyle(fontSize: 17, letterSpacing: percentToPx(-0.31), height: 1.29);
  static final bodyMedium = TextStyle(fontSize: 13, letterSpacing: percentToPx(-0.15), height: 1.23);
  static const bodySmall = TextStyle(fontSize: 12, height: 1.33);
  static final labelMedium = TextStyle(fontSize: 12, letterSpacing: percentToPx(2.1), height: 1.33);
  static const labelSmall = TextStyle(fontSize: 11, height: 1.09);
  static const hint = TextStyle(color: AppColors.grey50, fontWeight: FontWeight.w300);
}

/// value in % to the same value in px
double percentToPx(double value) => 0.16 * value.abs();