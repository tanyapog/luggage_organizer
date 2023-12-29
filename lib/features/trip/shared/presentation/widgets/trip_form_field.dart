import 'package:flutter/material.dart';

import '../../../../../global/presentation/theme/app_colors.dart';
import '../../../../../global/presentation/theme/app_input.dart';
import '../../../../../global/presentation/theme/app_padding.dart';
import '../../../../../global/presentation/theme/app_text.dart';

class TripFormField extends StatefulWidget {
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
  State<TripFormField> createState() => _TripFormFieldState();
}

class _TripFormFieldState extends State<TripFormField> {
  final controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.initialValue ?? "";
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant TripFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      controller.text = widget.initialValue ?? "";
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines,
      minLines: 1,
      maxLength: 70,
      validator: widget.validator,
      onChanged: widget.onChanged,
      controller: controller,
      style: AppTextStyle.titleSmall.copyWith(color: AppColors.grey90),
      decoration: AppInputDecoration.noBorder.copyWith(
        contentPadding: AppPadding.vertical15,
        hintText: widget.hintText,
      ),
    );
  }
}