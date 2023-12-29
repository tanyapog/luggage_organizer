import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../global/presentation/theme/app_buttons.dart';
import '../../../../../global/presentation/theme/app_padding.dart';
import '../../../../../global/presentation/validator.dart';
import '../../logic/trip_form/trip_form_bloc.dart';
import 'trip_form_field.dart';

class TripForm extends StatelessWidget {
  static final _globalTripFormKey = GlobalKey<FormState>();

  const TripForm({super.key});

  @override
  Widget build(BuildContext context) {
    final tripFormBloc = context.read<TripFormBloc>();
    var trip = context.watch<TripFormBloc>().state.trip;
    return BlocBuilder<TripFormBloc, TripFormState>(
      bloc: tripFormBloc,
      builder: (context, state) => Form(
          key: _globalTripFormKey,
          child: Padding(
            padding: AppPadding.fullScreenForm,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min, // To make the card compact
                  children: <Widget>[
                    TripFormField( // name field
                      initialValue: trip.name,
                      onChanged: (value) => tripFormBloc.add(TripFormEvent.nameChanged(value)),
                      validator: Validator.isNotEmpty,
                      hintText: 'Name',
                    ),
                    const SizedBox(height: 8),
                    TripFormField(
                      initialValue: trip.description,
                      onChanged: (value) => tripFormBloc.add(TripFormEvent.descriptionChanged(value)),
                      hintText: 'Description',
                      maxLines: 5,
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppButtons.gray(
                      title: "CANCEL",
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(width: 10),
                    AppButtons.colored(
                      title: "SAVE",
                      onPressed: () {
                        _globalTripFormKey.currentState!.validate()
                          ? tripFormBloc.add(const TripFormEvent.saved())
                          : null;
                        if (tripFormBloc.state.isEditing) Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }
}
