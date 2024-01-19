import 'package:flutter/material.dart';

import '../../../theme/app_icon.dart';
import '../../../theme/app_text.dart';

class MoreDropDownMenu extends StatelessWidget {
  final List<MenuItem> menuItems;
  const MoreDropDownMenu({super.key, required this.menuItems});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MenuAnchor(
          menuChildren: menuItems,
          builder: (context, controller, child) {
            return TextButton(
              onPressed: () => controller.isOpen ? controller.close() : controller.open(),
              child: const SizedBox.square(
                dimension: 40,
                child: Icon24(Icons.more_vert, color: Colors.white),
              ),
            );
          },
        ),
      ],
    );
  }
}

class MenuItem extends StatelessWidget {
  final void Function() onPressed;
  final String label;
  const MenuItem({super.key, required this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    return MenuItemButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          label,
          style: AppTextStyle.titleSmall.copyWith(fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
