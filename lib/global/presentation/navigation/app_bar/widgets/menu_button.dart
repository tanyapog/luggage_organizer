import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../routing/router.gr.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => AutoRouter.of(context).push(const MenuRoute()),
        icon: const Icon(Icons.menu),
    );
  }
}
