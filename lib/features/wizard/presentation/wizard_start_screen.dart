import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:luggage_organizer/global/presentation/navigation/widgets/menu_button.dart';

@RoutePage()
class WizardStartScreen extends StatelessWidget {
  const WizardStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const MenuButton(),
          title: const Text("New trip"),
      ),
      body: const Center(child: Text("Create a luggage check list for your next trip")),
    );
  }
}
