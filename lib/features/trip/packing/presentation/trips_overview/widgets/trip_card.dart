import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../../../global/domain/models/trip/trip.dart';
import '../../../../../../global/presentation/messages.dart';
import '../../../../../../global/presentation/routing/router.gr.dart';
import '../../../../../../global/presentation/theme/app_colors.dart';
import '../../../../../../injection.dart';
import '../../../logic/trip_actor/trip_actor_bloc.dart';

class TripCard extends StatelessWidget {
  final Trip trip;

  const TripCard({super.key, required this.trip,});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TripActorBloc>(),
      child: BlocListener<TripActorBloc, TripActorState>(
        listener: (context, state) {
          state.maybeMap(
            markAsCompletedFailed: (failedState) => showError(context, failedState.errorMessage) ,
            orElse: () => null,
          );
        },
        child: InkWell(
          onTap: () => context.navigateTo(TripEditRoute(trip: trip)),
          child: Slidable(
            endActionPane: ActionPane(
                motion: const BehindMotion(),
                extentRatio: 0.16,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: BlocBuilder<TripActorBloc, TripActorState>(
                        builder: (context, state) => CompleteButton(trip),
                      ),
                    ),
                  )
                ]
            ),
            child: Card(
              child: ListTile(
                title: Text(trip.name, style: _getStyle(trip.complete)),
                subtitle: trip.description.isNotEmpty ? Text(trip.description, style: _getStyle(trip.complete)) : null,
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextStyle _getStyle(bool complete) => TextStyle(color: complete ? AppColors.grey90 : AppColors.grey60);
}

class CompleteButton extends StatelessWidget {
  final Trip trip;
  const CompleteButton(this.trip, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.read<TripActorBloc>().add(TripActorEvent.markAsCompleted(trip)),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: trip.complete ? AppColors.primaryDark : AppColors.grey50,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(
          trip.complete ? Icons.check_box_outlined: Icons.check_box_outline_blank,
          color: Colors.white,
        ),
      ),
    );
  }
}