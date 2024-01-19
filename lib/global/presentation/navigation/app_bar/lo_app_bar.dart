import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text.dart';
import 'widgets/nav_actions.dart';

class LoAppBar extends AppBar {
  LoAppBar({
    super.key,
    super.leading,
    required String title,
    List<Widget>? actions,
  }) : super(
    backgroundColor: AppColors.primary,
    iconTheme: const IconThemeData(color: Colors.white),
    title: Center(child: Text(title, style: AppTextStyle.headlineSmall.copyWith(color: Colors.white))),
    actions: (actions != null && actions.isNotEmpty)
        ? [...actions]
        : [NavAction.empty()],
  );
}
