import 'package:flutter/material.dart';

import '../../../widgets/box.dart';
import '../lo_app_bar.dart';
import 'more_dropdown_menu.dart';

enum NavActionType { more, empty }

class NavAction extends StatelessWidget {
  final NavActionType navAction;
  final List<MenuItem>? menuItems;

  const NavAction._(this.navAction, [this.menuItems]);

  /// "More" button for [LoAppBar]
  factory NavAction.more(List<MenuItem> menuItems) => NavAction._(NavActionType.more, menuItems);

  /// Adds space when there is nothing to show in actions of [LoAppBar]
  factory NavAction.empty() => const NavAction._(NavActionType.empty);

  @override
  Widget build(BuildContext context) {
    switch (navAction) {
      case NavActionType.more:
        return MoreDropDownMenu(menuItems: menuItems ?? []);
      case NavActionType.empty:
        return Box.s40;
    }
  }
}