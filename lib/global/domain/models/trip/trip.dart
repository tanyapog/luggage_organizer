import 'package:freezed_annotation/freezed_annotation.dart';

import '../trip_type/trip_type.dart';

part 'trip.freezed.dart';

@freezed
class Trip with _$Trip {
  const Trip._();

  const factory Trip({
    String? id,
    required String name,
    required String description,
    TripType? type,
    @Default(false) bool complete,
    required  DateTime dateCreated,
  }) = _Trip;

  factory Trip.empty() => Trip(
    name: "",
    description: "",
    dateCreated: DateTime.now(),
  );
}
