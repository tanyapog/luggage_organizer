import 'package:freezed_annotation/freezed_annotation.dart';

part 'trip.freezed.dart';

// todo tags. Maybe from selected tripFeatures
@freezed
class Trip with _$Trip {
  const Trip._();

  const factory Trip({
    String? id,
    required String name,
    required String description,
    @Default(false) bool complete,
    required  DateTime dateCreated,
  }) = _Trip;

  factory Trip.empty() => Trip(
    name: "",
    description: "",
    dateCreated: DateTime.now(),
  );
}
