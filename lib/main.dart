import 'package:flutter/material.dart';
import 'package:luggage_organizer/features/auth/presentation/sign_in_screen.dart';

void main() {
  runApp(const LuggageOrganizerApp());
}

class LuggageOrganizerApp extends StatelessWidget {
  const LuggageOrganizerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "LuggageOrganizer",
      home: SignInScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
