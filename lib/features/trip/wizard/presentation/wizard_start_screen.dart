import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../global/presentation/navigation/app_bar/lo_app_bar.dart';
import '../../../../global/presentation/navigation/app_bar/widgets/menu_button.dart';
import '../../../../injection.dart';
import '../../shared/logic/trip_form/trip_form_bloc.dart';
import '../../shared/presentation/widgets/trip_form.dart';

@RoutePage()
class WizardStartScreen extends StatelessWidget {
  const WizardStartScreen({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: LoAppBar(
          leading: const MenuButton(),
          title: "New trip",
      ),
      body: BlocProvider<TripFormBloc>(
        create: (context) => getIt<TripFormBloc>(),
        child: const TripForm(),
      ),
    );
  }
}
