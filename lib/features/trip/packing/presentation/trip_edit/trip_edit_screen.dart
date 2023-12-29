import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../global/domain/models/trip/trip.dart';
import '../../../../../global/presentation/navigation/app_bar/lo_app_bar.dart';
import '../../../../../injection.dart';
import '../../../shared/logic/trip_form/trip_form_bloc.dart';
import '../../../shared/presentation/widgets/trip_form.dart';

@RoutePage()
class TripEditScreen extends StatelessWidget {
  final Trip trip;

  const TripEditScreen({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LoAppBar(title: "Edit trip"),
      body: BlocProvider(
        create: (context) => getIt<TripFormBloc>(param1: trip),
        child: const TripForm(),
      ),
    );
  }
}