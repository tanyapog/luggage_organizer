import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../global/presentation/navigation/app_bar/lo_app_bar.dart';
import '../../../../../global/presentation/navigation/app_bar/widgets/menu_button.dart';
import '../../../../../global/presentation/routing/router.gr.dart';
import '../../../../../global/presentation/theme/app_colors.dart';
import '../../../../../injection.dart';
import '../../logic/trip_watcher/trip_watcher_bloc.dart';
import 'widgets/trips_overview_body.dart';

@RoutePage()
class TripsOverviewScreen extends StatelessWidget {
  const TripsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TripWatcherBloc>(
      create: (context) => getIt<TripWatcherBloc>()
        ..add(const TripWatcherEvent.watchAll()),
      child: Scaffold(
        appBar: LoAppBar(
          leading: const MenuButton(),
          title: "Trips",
        ),
        body: const TripsOverviewBody(),
        floatingActionButton: const _PlusBottomBarButton(),
      ),
    );
  }
}

class _PlusBottomBarButton extends StatelessWidget {
  const _PlusBottomBarButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: FloatingActionButton(
        onPressed: () => AutoRouter.of(context).push(const WizardStartRoute()),
        backgroundColor: AppColors.button,
        elevation: 0,
        child: const Icon(Icons.add, size: 38, color: AppColors.grey10),
      ),
    );
  }
}

