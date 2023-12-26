import 'package:flutter/material.dart';
import 'package:luggage_organizer/global/presentation/theme/app_icon.dart';
import 'package:luggage_organizer/global/presentation/widgets/box.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_padding.dart';
import '../../theme/app_text.dart';

class ErrorFullscreen extends StatelessWidget {
  final String? errorMessage;

  const ErrorFullscreen({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Box.s160,
              const Icon(
                AppIcon.sad,
                color: AppColors.error,
                size: 160,
              ),
              Box.s24,
              Padding(
                padding: AppPadding.horizontal,
                child: Text(errorMessage ?? '',
                  style: AppTextStyle.titleMedium.copyWith(color: AppColors.grey90),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}