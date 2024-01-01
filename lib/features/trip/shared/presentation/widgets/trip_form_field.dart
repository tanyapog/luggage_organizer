import 'package:flutter/material.dart';

import '../../../../../global/presentation/theme/app_colors.dart';
import '../../../../../global/presentation/theme/app_input.dart';
import '../../../../../global/presentation/theme/app_padding.dart';
import '../../../../../global/presentation/theme/app_text.dart';

class TripFormField extends StatelessWidget {
  const TripFormField({
    super.key, 
    this.initialValue, 
    this.hintText, 
    this.onChanged,
    this.validator,
    this.maxLines = 1,
  });

  final String? initialValue;
  final String? hintText;
  final void Function(String value)? onChanged;
  final FormFieldValidator<String>? validator;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      validator: validator,
      maxLines: maxLines,
      minLines: 1,
      maxLength: 70,
      style: AppTextStyle.titleSmall.copyWith(color: AppColors.grey90),
      decoration: AppInputDecoration.noBorder.copyWith(
        contentPadding: AppPadding.vertical15,
        hintText: hintText,
      ),
    );
  }
}