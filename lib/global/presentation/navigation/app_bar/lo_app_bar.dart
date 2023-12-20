import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text.dart';
import '../../widgets/box.dart';


class LoAppBar extends AppBar {
  LoAppBar({
    super.key,
    super.leading,
    required String title,
  }) : super(
    backgroundColor: AppColors.primary,
    iconTheme: const IconThemeData(color: Colors.white),
    title: Center(child: Text(title, style: AppTextStyle.headlineSmall.copyWith(color: Colors.white))),
    actions: [Box.s40, Box.s16],
  );
}
