import 'package:flutter/material.dart';

import 'app_borders.dart';
import 'app_colors.dart';

class AppInputDecoration {
  static const roundedBorder = InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.primary),
      borderRadius: AppBorderRadius.border4,
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.error),
      borderRadius: AppBorderRadius.border4,
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.error),
      borderRadius: AppBorderRadius.border4,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.grey70),
      borderRadius: AppBorderRadius.border4,
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.grey50),
      borderRadius: AppBorderRadius.border4,
    ),
  );
}