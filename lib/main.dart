import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:luggage_organizer/utils/logging.dart';

import 'firebase_options.dart';
import 'global/presentation/routing/router.dart';
import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppLogger().init();
  await configureInjection(Environment.prod);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(LuggageOrganizerApp());
}

class LuggageOrganizerApp extends StatelessWidget {
  LuggageOrganizerApp({super.key});
  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter.config(),
      debugShowCheckedModeBanner: false,
    );
  }
}