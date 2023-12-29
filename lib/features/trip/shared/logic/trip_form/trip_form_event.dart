part of 'trip_form_bloc.dart';

@freezed
class TripFormEvent with _$TripFormEvent {
  const factory TripFormEvent.nameChanged(String name) = _NameChanged;
  const factory TripFormEvent.descriptionChanged(String description) = _DescriptionChanged;
  const factory TripFormEvent.completedPressed() = _CompletedPressed;
  const factory TripFormEvent.saved() = _Saved;
}
