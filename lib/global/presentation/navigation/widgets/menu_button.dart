import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:luggage_organizer/global/presentation/routing/router.gr.dart';
import 'package:luggage_organizer/global/presentation/theme/app_colors.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => AutoRouter.of(context).push(const MenuRoute()),
        icon: const Icon(Icons.person, color: AppColors.iconColor),
    );
  }
}
