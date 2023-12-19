import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../global/presentation/theme/app_colors.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.primary,
        child: const Center(child: Text(
          "Get prepared for your next trip!",
          style: TextStyle(color: Colors.white, fontSize: 20),
        )),
      ),
    );
  }
}
