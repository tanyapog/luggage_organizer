import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppIcon {
  AppIcon._();

  static const _kFontFam = 'AppIcon';
  static const String? _kFontPkg = null;

  static const IconData sad = IconData(0xe855, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}

class Icon24 extends StatelessWidget {
  final IconData iconData;
  final Color color;

  const Icon24(this.iconData, {super.key, this.color = AppColors.iconColor});

  @override
  Widget build(BuildContext context) {
    return Icon(iconData, color: color, size: 24);
  }
}