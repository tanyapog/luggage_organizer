import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../../global/domain/models/trip/trip.dart';
import '../../../../../../global/presentation/routing/router.gr.dart';

class TripCard extends StatelessWidget {
  final Trip trip;

  const TripCard({super.key, required this.trip,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.navigateTo(TripEditRoute(trip: trip)),
      child: Card(
        child: ListTile(
          title: Text(trip.name),
          subtitle: trip.description.isNotEmpty ? Text(trip.description) : null,
        ),
      ),
    );
  }
}
