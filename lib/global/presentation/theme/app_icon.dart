import 'package:flutter/material.dart';

import 'app_colors.dart';

class Icon24 extends StatelessWidget {
  final IconData iconData;
  final Color color;

  const Icon24(this.iconData, {super.key, this.color = AppColors.iconColor});

  @override
  Widget build(BuildContext context) {
    return Icon(iconData, color: color, size: 24);
  }
}