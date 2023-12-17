import 'package:flutter/material.dart';

import 'widgets/errors/error_snack_bar.dart';

void showError(BuildContext context, String message, {Key? key}) =>
    ScaffoldMessenger.of(context)
        .showSnackBar(ErrorSnackBar(key: key, message: message));