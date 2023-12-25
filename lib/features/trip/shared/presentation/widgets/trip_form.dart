import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:luggage_organizer/global/presentation/theme/app_padding.dart';

import '../../../../../global/presentation/theme/app_buttons.dart';
import '../../../../../global/presentation/theme/app_input.dart';
import '../../../../../global/presentation/validator.dart';
import '../../logic/trip_form/trip_form_bloc.dart';

class TripForm extends HookWidget {
  static final GlobalKey<FormState> _globalTripFormKey = GlobalKey<FormState>();

  const TripForm({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final descriptionController = useTextEditingController();

    return Form(
      key: _globalTripFormKey,
      child: Padding(
        padding: AppPadding.fullScreenForm,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min, // To make the card compact
              children: <Widget>[
                TextFormField( // name field
                  controller: nameController,
                  decoration: AppInputDecoration.noBorder.copyWith(
                    contentPadding: AppPadding.vertical15,
                    hintText: 'Name',
                  ),
                  maxLength: 70,
                  onChanged: (value) => context.read<TripFormBloc>().add(TripFormEvent.nameChanged(value)),
                  validator: Validator.isNotEmpty,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: descriptionController,
                  decoration: AppInputDecoration.noBorder.copyWith(
                    contentPadding: AppPadding.vertical15,
                    hintText: 'Description',
                  ),
                  maxLength: 100, //todo const
                  maxLines: 5,
                  minLines: 1,
                  onChanged: (value) => context.read<TripFormBloc>().add(TripFormEvent.descriptionChanged(value)),
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
                  onPressed: () => _globalTripFormKey.currentState!.validate()
                      ? context.read<TripFormBloc>().add(const TripFormEvent.saved())
                      : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
