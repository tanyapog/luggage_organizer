import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../global/domain/models/trip/i_trip_repository.dart';
import '../../../../../global/domain/models/trip/trip.dart';
import '../../../../../global/domain/models/trip/trip_failure.dart';

part 'trip_form_event.dart';
part 'trip_form_state.dart';
part 'trip_form_bloc.freezed.dart';

@injectable
class TripFormBloc extends Bloc<TripFormEvent, TripFormState> {
  final ITripRepository _tripRepository;

  TripFormBloc(
      this._tripRepository,
      // trip as a parameter helps escape the error
      // "setState() or markNeedsBuild() called during build"
      // that arise in TripFormField's state didUpdateWidget() if trip is set through event.
      @factoryParam Trip? trip
  ) : super(TripFormState.initial(trip)) {

    on<TripFormEvent>((event, emit) => event.map(
      nameChanged: (event) => emit(state.copyWith(
        trip: state.trip.copyWith(name: event.name))),

      descriptionChanged: (event) => emit(state.copyWith(
        trip: state.trip.copyWith(description: event.description))),

      completedPressed: (event) => emit(state.copyWith(
        trip: state.trip.copyWith(complete: !state.trip.complete))),

      saved: (event) async {
        emit(state.copyWith(loading: true, errorMessage: null));
        try {
          state.isEditing
              ? await _tripRepository.update(state.trip)
              : await _tripRepository.create(state.trip);
          emit(state.copyWith(loading: false, errorMessage: null, issueCreated: true));
        } on TripFailure catch (e) {
          emit(state.copyWith(loading: false, errorMessage: e.message, issueCreated: false));
        } on Exception catch (e) {
          emit(state.copyWith(loading: false, errorMessage: "$e", issueCreated: false));
        }
        return null;
      },
    ), transformer: sequential());
  }
}
