import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class WizardStartScreen extends StatelessWidget {
  const WizardStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New trip")),
      body: const Center(child: Text("Create a luggage check list for your next trip")),
    );
  }
}
