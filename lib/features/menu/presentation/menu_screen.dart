import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../global/presentation/messages.dart';
import '../../../global/presentation/navigation/app_bar/lo_app_bar.dart';
import '../../../global/presentation/theme/app_borders.dart';
import '../../../global/presentation/theme/app_padding.dart';
import '../../auth/logic/authentication/auth_bloc.dart';

@RoutePage()
class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LoAppBar(title: "Luggage organizer menu"),
      body: const SafeArea(
        child: _LogOutButton(),
      ),
    );
  }
}

class _LogOutButton extends StatelessWidget {
  const _LogOutButton();

  @override
  Widget build(BuildContext context) => Container(
    decoration: const BoxDecoration(borderRadius: AppBorderRadius.border4),
    clipBehavior: Clip.hardEdge,
    margin: AppPadding.horizontal,
    height: 30,
    width: double.maxFinite,
    child: TextButton(
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        child: const Text("Log out"),
        onPressed: () async {
          final authBloc = context.read<AuthBloc>();
          final wantToLogOut = await showYesNoDialog(context: context, title: "Do you want to log out?");
          if (wantToLogOut == true) {
            authBloc.add(const AuthEvent.signedOut());
          }
        }),
  );
}
