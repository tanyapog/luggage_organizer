import 'package:flutter/material.dart';

void main() {
  runApp(const LuggageOrganizerApp());
}

class LuggageOrganizerApp extends StatelessWidget {
  const LuggageOrganizerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "LuggageOrganizer",
      home: Scaffold(
        appBar: AppBar(title: const Text("LuggageOrganizer")),
        body: const Center(child: Text("LuggageOrganizer")),
      ),
    );
  }
}
