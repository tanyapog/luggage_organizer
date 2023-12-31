import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'features/auth/logic/authentication/auth_bloc.dart';
import 'firebase_options.dart';
import 'global/presentation/routing/router.dart';
import 'global/presentation/routing/router.gr.dart';
import 'injection.dart';
import 'utils/logging/app_bloc_observer.dart';
import 'utils/logging/logging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppLogger().init();
  await configureInjection(Environment.prod);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = AppBlocObserver();
  runApp(LuggageOrganizerApp());
}

class LuggageOrganizerApp extends StatelessWidget {
  LuggageOrganizerApp({super.key});

  final router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      getIt<AuthBloc>()
        ..add(const AuthEvent.authCheckRequested()),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          switch (state.authStatus) {
            case AuthStatus.authenticated:
              router.replace(const AuthorizedRoute());
              break;
            case AuthStatus.unauthenticated:
              router.replace(const SignInRoute());
              break;
            case AuthStatus.unknown:
              break;
          }
        },
        child: MaterialApp.router(
          routerConfig: router.config(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}