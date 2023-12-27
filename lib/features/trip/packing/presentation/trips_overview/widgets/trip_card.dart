import 'package:flutter/material.dart';

import '../../../../../../global/domain/models/trip/trip.dart';

class TripCard extends StatelessWidget {
  final Trip trip;

  const TripCard({super.key, required this.trip,});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(trip.name),
        subtitle: trip.description.isNotEmpty ? Text(trip.description) : null,
      ),
    );
  }
}
