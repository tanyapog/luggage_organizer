import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../global/presentation/navigation/app_bar/lo_app_bar.dart';
import '../../../global/presentation/navigation/app_bar/widgets/menu_button.dart';

@RoutePage()
class WizardStartScreen extends StatelessWidget {
  const WizardStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LoAppBar(
          leading: const MenuButton(),
          title: "New trip",
      ),
      body: const Center(child: Text("Create a luggage check list for your next trip")),
    );
  }
}
