import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppButtons {
  AppButtons._();

  static Widget texted({
    required String title,
    required void Function() onPressed,
  }) => TextButton (
    onPressed: onPressed,
    child: Text(title, style: const TextStyle(color: AppColors.primaryDark, fontWeight: FontWeight.bold)),
  );

  static Widget colored ({
    required String title,
    required void Function() onPressed,
  }) => ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(backgroundColor: AppColors.button),
    child: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
  );

  static Widget gray ({
    required String title,
    required void Function() onPressed,
  }) => ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(backgroundColor: AppColors.grey50),
    child: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
  );
}
