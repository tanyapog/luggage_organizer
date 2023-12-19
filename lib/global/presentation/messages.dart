import 'package:flutter/material.dart';

import 'widgets/errors/error_snack_bar.dart';

void showError(BuildContext context, String message, {Key? key}) =>
    ScaffoldMessenger.of(context)
        .showSnackBar(ErrorSnackBar(key: key, message: message));

Future<bool?> showYesNoDialog({
  required BuildContext context,
  required String title,
  Widget? content,
}) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: content,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text("No"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text("Yes"),
        ),
      ],
    ),
);