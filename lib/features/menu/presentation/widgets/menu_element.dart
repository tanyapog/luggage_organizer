import 'package:flutter/material.dart';

import '../../../../global/presentation/theme/app_colors.dart';
import '../../../../global/presentation/theme/app_icon.dart';
import '../../../../global/presentation/theme/app_padding.dart';
import '../../../../global/presentation/theme/app_text.dart';

class MenuElement extends StatelessWidget {
  final Function()? onTap;
  final String title;
  final IconData? iconData;
  final bool showTrailing;

  const MenuElement({
    super.key,
    this.onTap,
    required this.title,
    this.iconData,
    this.showTrailing = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppColors.grey10),
      child: ListTile(
        horizontalTitleGap: 0,
        onTap: onTap,
        leading: iconData != null ? Padding(
          padding: AppPadding.right16,
          child: Icon24(iconData!),
        ) : null,
        title: Text(title, style: AppTextStyle.titleMedium.copyWith(color: AppColors.grey90)),
        trailing: showTrailing ? const Icon24(Icons.chevron_right) : null,
      ),
    );
  }
}