import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../global/domain/models/user/i_auth_facade.dart';
import '../../../global/presentation/messages.dart';
import '../../../global/presentation/navigation/app_bar/lo_app_bar.dart';
import '../../../global/presentation/routing/router.gr.dart';
import '../../../global/presentation/theme/app_padding.dart';
import '../../../global/presentation/widgets/box.dart';
import '../../../injection.dart';
import '../../auth/logic/authentication/auth_bloc.dart';
import 'widgets/menu_element.dart';

@RoutePage()
class MenuScreen extends StatelessWidget {
  final IAuthFacade _auth = getIt<IAuthFacade>();

  MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LoAppBar(title: "Luggage organizer menu"),
      body: Padding(
        padding: AppPadding.horizontal,
        child: Column(
          children: [
            Box.s32,
            MenuElement(iconData: Icons.person, title: _auth.signedInUser?.email ?? "username"),
            Box.s8,
            MenuElement(
              onTap: () => context.navigateTo(const TripsOverviewRoute()),
              title: "Trips",
              iconData: Icons.card_travel,
              showTrailing: true,
            ),
            Box.s8,
            const MenuElement(iconData: Icons.category, title: "Categories", showTrailing: true),
            Box.s8,
            MenuElement(iconData: Icons.logout, title: "Log out", onTap: () async {
              final authBloc = context.read<AuthBloc>();
              final wantToLogOut = await showYesNoDialog(context: context, title: "Do you want to log out?");
              if (wantToLogOut == true) {
                authBloc.add(const AuthEvent.signedOut());
              }
            }),
          ],
        ),
      ),
    );
  }
}
