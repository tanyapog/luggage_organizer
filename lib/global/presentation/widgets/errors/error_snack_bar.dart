import 'package:flutter/material.dart';

import '../box.dart';

class ErrorSnackBar extends SnackBar {
  final String message;
  ErrorSnackBar({super.key, required this.message}) : super(
    duration: const Duration(seconds: 5),
    content: Row(
      children: [
        const Icon(Icons.warning, color: Colors.red,),
        Box.s8,
        Flexible(child: Text(message)),
      ],
    ),
  );
}