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
      builder: (context, state) {
        switch (state.status) {
          case Status.loading:
            return const Center(child: CircularProgressIndicator());
          case Status.success:
            return Padding(
              padding: AppPadding.fullScreenList,
              child: state.trips != null
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      final trip = state.trips![index];
                      return TripCard(trip: trip); // todo error trip card
                    },
                    itemCount: state.trips!.length,
                  )
                : const Center(child: Text("You have no any trips yet"))
            );
          case Status.failure:
            return ErrorFullscreen(errorMessage: state.errorMessage);
        }
      },
    );
  }
}
