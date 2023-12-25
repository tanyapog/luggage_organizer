part of 'trip_form_bloc.dart';

@freezed
class TripFormState with _$TripFormState {
  const factory TripFormState({
    required Trip trip,
    required bool isEditing,
    @Default(true) loading,
    @Default(false) bool issueCreated,
    String? errorMessage,
  }) = _TripFormState;

  factory TripFormState.initial() => TripFormState(
    trip: Trip.empty(),
    isEditing: false,
  );
}
