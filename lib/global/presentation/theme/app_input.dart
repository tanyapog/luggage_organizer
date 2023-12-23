import 'package:flutter/material.dart';

import 'app_borders.dart';
import 'app_colors.dart';
import 'app_padding.dart';
import 'app_text.dart';

class AppInputDecoration {

  static const noBorder = InputDecoration(
    hintStyle: AppTextStyle.hint,
    counterText: '',
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: AppColors.primary),
      borderRadius: AppBorderRadius.border4,
    ),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: AppColors.error),
      borderRadius: AppBorderRadius.border4,
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: AppColors.error),
      borderRadius: AppBorderRadius.border4,
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: AppColors.grey70),
      borderRadius: AppBorderRadius.border4,
    ),
    disabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: AppColors.grey50),
      borderRadius: AppBorderRadius.border4,
    ),
  );

  static const roundedBorder = InputDecoration(
    hintStyle: AppTextStyle.hint,
    contentPadding: AppPadding.vertical15,
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