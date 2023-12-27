import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../global/presentation/theme/app_padding.dart';
import '../../../../../../global/presentation/widgets/errors/error_full_screen.dart';
import '../../../logic/trip_watcher/trip_watcher_bloc.dart';
import 'trip_card.dart';

class TripsOverviewBody extends StatelessWidget {
  const TripsOverviewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripWatcherBloc, TripWatcherState>(
      builder: (context, state) => state.map(
        initial: (_) => Container(),
        loading: (_) => const Center(child: CircularProgressIndicator()),
        succeed: (state) =>
            Padding(
              padding: AppPadding.fullScreenList,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final trip = state.trips[index];
                  return TripCard(trip: trip); // todo error trip card
                },
                itemCount: state.trips.length,
              ),
            ),
        failed: (state) => ErrorFullscreen(errorMessage: state.tripFailure.message),
      ),
    );
  }
}
