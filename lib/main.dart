import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:luggage_organizer/features/auth/presentation/sign_in_screen.dart';
import 'package:luggage_organizer/utils/logging.dart';

import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppLogger().init();
  await configureInjection(Environment.prod);
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